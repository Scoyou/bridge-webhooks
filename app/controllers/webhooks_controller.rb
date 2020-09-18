class WebhooksController < ApplicationController
    def create_registration
        data = JSON.parse(request.body.read)
        
        puts data

        user = User.find_or_create_by(uid: data['learner']['uid'])

        registration = Registration.create!(
            user_id: User.find_by(uid: data['learner']['uid']).id, 
            bridge_registration_id: data['live_course_session_registration']['id'],
            live_course_session_id: data['live_course_session']['id'],
            live_course_id: data['live_course']['id'],
            uid: data['learner']['uid']
    )

    user.number_of_registrations == nil ? user.update(number_of_registrations: 1) 
    : user.update(number_of_registrations: user.number_of_registrations + 1)


        head :ok
    end

    def delete_registration
        data = JSON.parse(request.body.read)

        puts data

        registration = Registration.find_by(bridge_registration_id: data['live_course_session_registration']['id'])
        user = User.find(registration.user_id)

        registration.destroy!

        user.update(number_of_registrations: user.number_of_registrations - 1)
    end
end
