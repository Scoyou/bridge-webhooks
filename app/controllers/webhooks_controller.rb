class WebhooksController < ApplicationController

    
    def create
        data = JSON.parse(request.body.read)

        CreateRegistrationWorker.perform_async(data)

        head :ok
    end

    def destroy
        data = JSON.parse(request.body.read)

        DestroyRegistrationWorker.perform_async(data)
    end

    def update
        data = JSON.parse(request.body.read)
        registration_id = data['live_course_session_registration']['id']
        registration = Registration.find_by(bridge_registration_id: registration_id)

        marked_complete = data['live_course_session_registration']['marked_complete_at']

        if marked_complete
            registration.update(is_attended: true)
        else
            registration.update(is_attended: false)
        end

    end
end
