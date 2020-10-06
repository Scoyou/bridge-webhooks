# frozen_string_literal: true

class CreateRegistrationWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(data)
    user = User.find_or_create_by(uid: data['learner']['uid'])
    registration_id = data['live_course_session_registration']['id']
    live_course_session_id = data['live_course_session']['id']
    live_course_id = data['live_course']['id']
    marked_attended = data['live_course_session_registration']['marked_complete_at'] ? true : false

    lc_title = data['live_course']['title']
    lc_date = Time.parse(data['live_course_session']['start_at'])

    registration = Registration.create!(
      user_id: User.find_by(uid: user.uid).id,
      bridge_registration_id: registration_id,
      live_course_session_id: live_course_session_id,
      live_course_id: data['live_course']['id'],
      live_course_title: lc_title,
      session_start_time: lc_date,
      uid: user.uid,
      is_attended: marked_attended
    )

    user.number_of_registrations.nil? ? user.update(number_of_registrations: 1)
    : user.update(number_of_registrations: user.number_of_registrations + 1)

    message = "You have successfully registered for live course: #{lc_title}, which starts: #{lc_date}"
    number = user.phone_number

    MessageUserWorker.perform_async(message, number) unless marked_attended
  end
end
