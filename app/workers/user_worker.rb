class UserWorker
    include Sidekiq::Worker
    sidekiq_options retry: false

    require 'csv'

    def perform
        sftp = Net::SFTP.start(
            '35.224.193.198',
            Rails.application.credentials.auto_csv[:user_name], 
            :password => Rails.application.credentials.auto_csv[:password])
        sftp.file.open("/home/bridge/bridgeautocsv.csv", "r") do |f|
            while !f.eof?
                row = f.gets
                cols = row.split(',')

                user = User.find_or_create_by(uid: cols[1])
                user.update(phone_number: cols[3].strip)
            end
        end
    end
end