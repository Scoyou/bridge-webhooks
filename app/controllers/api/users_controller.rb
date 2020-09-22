class Api::UsersController < ApplicationController
    require 'net/sftp'
    require 'pry'

    def index
        @users = Users.all
    end

    def add_to_db
        # moved to user_worker.rb
        # sftp = Net::SFTP.start(
        #     '35.224.193.198',
        #     Rails.application.credentials.auto_csv[:user_name], 
        #     :password => Rails.application.credentials.auto_csv[:password])
        # sftp.file.open("/home/bridge/bridgeautocsv.csv", "r") do |f|
        #     while !f.eof?
        #         row = f.gets
        #         cols = row.split(',')

        #         user = User.find_or_create_by(uid: cols[1])
        #         user.update(phone_number: cols[3].strip)
        #     end
        # end

        UserWorker.perform_async
    end
end
