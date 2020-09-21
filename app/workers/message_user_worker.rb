class MessageUserWorker
    include Sidekiq::Worker
    sidekiq_options retry: false

    def perform(message, number)     
        TwilioTexterController.new(message, number).call
    end
end