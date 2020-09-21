class CreateRegistrationWorker < ApplicationController
    include Sidekiq::Worker
    sidekiq_options retry: false

    def perform(data)
        user = User.find_or_create_by(uid: data['learner']['uid'])
        registration_id = data['live_course_session_registration']['id']
        live_course_session_id = data['live_course_session']['id']
        live_course_id = data['live_course']['id']

        lc_title = data['live_course']['title']
        lc_date = Time.parse(data['live_course_session']['start_at'])

        registration = Registration.create!(
            user_id: User.find_by(uid: user.uid).id, 
            bridge_registration_id: registration_id,
            live_course_session_id: live_course_session_id,
            live_course_id: data['live_course']['id'],
            uid: user.uid
        )

        user.number_of_registrations == nil ? user.update(number_of_registrations: 1) 
        : user.update(number_of_registrations: user.number_of_registrations + 1)

        message = "You have successfully registered for live course: #{lc_title}, which starts: #{lc_date}"
        number = user.phone_number

        MessageUserWorker.perform_async(message, number)
    end
end