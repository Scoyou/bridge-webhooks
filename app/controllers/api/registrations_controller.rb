class Api::RegistrationsController < ApplicationController
  def index
    render json: Registration.all
  end

  def update
    @registration = Registration.find(params[:id])
    if @registration.update(registration_params)
      render json: @registration
    else
      render json: { errors: @registration.errors }, status: :unprocessable_entity
    end
  end

  def sync_attendance
    SyncAttendanceWorker.perform_async
  end

  private
  def registration_params
    params.require(:registration).permit(:is_attended)
  end
end
