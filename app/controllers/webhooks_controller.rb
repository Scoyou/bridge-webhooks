class WebhooksController < ApplicationController
    require 'workers/create_registration_worker'
    require 'workers/destroy_registration_worker'
    
    def create_registration
        data = JSON.parse(request.body.read)

        # Moved to CreateRegistrationWorker.rb
        # user = User.find_or_create_by(uid: data['learner']['uid'])
        # registration_id = data['live_course_session_registration']['id']
        # live_course_session_id = data['live_course_session']['id']
        # live_course_id = data['live_course']['id']

        # lc_title = data['live_course']['title']
        # lc_date = Time.parse(data['live_course_session']['start_at'])

        # registration = Registration.create!(
        #     user_id: User.find_by(uid: user.uid).id, 
        #     bridge_registration_id: registration_id,
        #     live_course_session_id: live_course_session_id,
        #     live_course_id: data['live_course']['id'],
        #     uid: user.uid
        # )

        # user.number_of_registrations == nil ? user.update(number_of_registrations: 1) 
        # : user.update(number_of_registrations: user.number_of_registrations + 1)

        # message = "You have successfully registered for live course: #{lc_title}, which starts: #{lc_date}"
        # number = user.phone_number

        # TwilioTexterController.new(message, number).call

        CreateRegistrationWorker.perform_async(data)

        head :ok
    end

    def delete_registration
        data = JSON.parse(request.body.read)

        # Moved to DestroyRegistrationWorker.rb
        # registration = Registration.find_by(bridge_registration_id: data['live_course_session_registration']['id'])
        # user = User.find(registration.user_id)
        # live_course_session_id = data['live_course_session']['id']
        # live_course_id = data['live_course']['id']

        # lc_title = data['live_course']['title']
        # lc_date = Time.parse(data['live_course_session']['start_at'])

        # registration.destroy!

        # user.update(number_of_registrations: user.number_of_registrations - 1)

        # message = "You have successfully been removed from live course: #{lc_title}, session: #{live_course_session_id}"
        # number = user.phone_number

        # TwilioTexterController.new(message, number).call

        DestoryRegistrationWorker.perform_async(data)
    end
end
