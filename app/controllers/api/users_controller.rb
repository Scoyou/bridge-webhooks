# frozen_string_literal: true

class Api::UsersController < ApplicationController
  require 'net/sftp'
  require 'pry'

  def index
    @users = Users.all
  end

  def add_to_db
    UserWorker.perform_async
  end
end
