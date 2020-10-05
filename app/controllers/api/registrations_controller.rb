# frozen_string_literal: true

class Api::RegistrationsController < ApplicationController
  def index

    case params['is_attended']
    when "true"
      @registrations = Registration.where(is_attended: true)
    when "false"
      @registrations = Registration.where(is_attended: false)
    else
      @registrations = Registration.all
    end
    
    @registrations = Registration.where("uid ILIKE ?", "%#{params['uid']}%") if params['uid']
    @registrations = Registration.where(live_course_id: params['live_course_id']) if params['live_course_id']
    @registrations = Registration.where(live_course_session_id: params['live_course_session_id']) if params['live_course_session_id']
      
    render json: @registrations
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
    params.require(:registration).permit(
                                        :is_attended, 
                                        :uid,
                                        :live_course_id,
                                        :live_course_session_id
                                      )
  end
end
