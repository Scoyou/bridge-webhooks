# frozen_string_literal: true

class DestroyRegistrationWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(data)
    registration = Registration.find_by(bridge_registration_id: data['live_course_session_registration']['id'])
    user = User.find(registration.user_id)
    live_course_session_id = data['live_course_session']['id']

    lc_title = data['live_course']['title']

    registration.destroy!

    user.update(number_of_registrations: user.number_of_registrations - 1)

    message = "You have successfully been removed from live course: #{lc_title}, session: #{live_course_session_id}"
    number = user.phone_number

    MessageUserWorker.perform_async(message, number)
  end
end
