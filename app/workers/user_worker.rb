class UserAddWorker
    include Sidekiq::Worker
    sidekiq_options retry: false

    require 'csv'

    def perform(csv_path)
        CSV.foreach((csv_path), headers: true) do |user|
            User.create(
                uid: user[0],
                number_of_registrations: user[1],
                phone_number: user[2]
            )
            flash[:notice] = "All users added"
        end
    end
end