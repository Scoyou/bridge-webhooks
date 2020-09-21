class Api::RegistrationsController < ApplicationController
    def index
        render json: Registration.all
      end
end
