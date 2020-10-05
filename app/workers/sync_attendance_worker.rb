# frozen_string_literal: true

class SyncAttendanceWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  include HTTParty

  def fetch_live_courses
    domain = Rails.application.credentials[:bridge][:domain]
    token = Rails.application.credentials[:bridge][:token]

    url = "https://#{domain}.bridgeapp.com"
    path = '/api/author/live_courses?limit=1000'
    headers = { 'Authorization' => token }
    response = HTTParty.get(url + path, headers: headers)
    data = JSON.parse(response.body)
    trainings = []
    if data['meta']['next']
      while data['meta']['next']
        lt = data['live_courses']
        lt.each { |lt| trainings << lt['id'] }
        response = HTTParty.get(data['meta']['next'], headers: headers)
        data = JSON.parse(response.body)
      end
    else
      lt = data['live_courses']
      lt.each { |lt| trainings << lt['id'] }
    end

    trainings
  end

  def fetch_sessions(live_course)
    sessions = []
    domain = Rails.application.credentials[:bridge][:domain]
    token = Rails.application.credentials[:bridge][:token]

    url = "https://#{domain}.bridgeapp.com"
    path = "/api/author/live_courses/#{live_course}/sessions?limit=1000"
    headers = { 'Authorization' => token }
    response = HTTParty.get(url + path, headers: headers)
    data = JSON.parse(response.body)
    if data['meta']['next']
      while data['meta']['next']
        session = data['sessions']
        session.each { |s| sessions << s['id'] }
        response = HTTParty.get(data['meta']['next'], headers: headers)
        data = JSON.parse(response.body)
      end
    else
      session = data['sessions']
      session.each { |s| sessions << s['id'] }
    end

    sessions
  end

  def fetch_session_registrations(session)
    domain = Rails.application.credentials[:bridge][:domain]
    token = Rails.application.credentials[:bridge][:token]

    url = "https://#{domain}.bridgeapp.com"
    path = "/api/author/live_course_sessions/#{session}/registrations"

    headers = { 'Authorization' => token }
    response = HTTParty.get(url + path, headers: headers)
    registrations = []
    data = JSON.parse(response.body)
    if data['meta']['next']
      while data['meta']['next']
        registration = data['registrations']
        registration.each { |r| registrations << r }
        response = HTTParty.get(data['meta']['next'], headers: headers)
        data = JSON.parse(response.body)
      end
    else
      registration = data['registrations']
      registration.each { |r| registrations << r }
    end

    registrations
  end

  def perform
    sessions = []
    live_courses = fetch_live_courses
    registrations = []

    live_courses.each do |lc|
      sessions << { lc => fetch_sessions(lc) }
    end

    sessions = sessions.reduce({}, :merge)

    sessions.values.flatten.each do |session|
      registrations << fetch_session_registrations(session)
    end

    registrations = registrations.flatten

    registrations.each do |r|
      user = User.find_by(uid: r['uid'])
      reg = Registration.find_or_create_by(bridge_registration_id: r['id'], user_id: user.id)
      is_attended = r['marked_complete_at'] ? true : false

      live_course_session_id = r['live_course_session_id']
      live_course = sessions.select { |_k, v| v.include?(r['live_course_session_id']) }.keys.first

      reg.update(
        is_attended: is_attended,
        live_course_id: live_course,
        live_course_session_id: live_course_session_id,
        uid: r['uid']
      )

      user.update(number_of_registrations: user.number_of_registrations += 1)
    end
  end
end
