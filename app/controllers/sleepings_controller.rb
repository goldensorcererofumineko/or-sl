class SleepingsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_sleep, only: [:show, :edit, :update, :destroy]
  def index
    @sleepings = Sleeping.all
    total_sleep_duration = @sleepings.sum { |sleeping| sleeping.sleep_duration.to_i }
    average_sleep_duration_minutes = total_sleep_duration / @sleepings.length
    @average_sleep_duration_hours = average_sleep_duration_minutes / 60
    @average_sleep_duration_minutes = average_sleep_duration_minutes % 60
  end

  def show
  end

  def new
    @sleeping = Sleeping.new
  end

  def create
    @sleepings = Sleeping.new(sleep_params)
    if @sleeping.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    @sleeping = Sleeping.find(params[:id])
    if sleep.update(sleep_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    @sleeping = Sleeping.find(params[:id])
    @sleeping.destroy
    redirect_to root_path
  end

  private

  def set_sleep
    @Sleeping = Sleeping.find(params[:id])
  end

  def sleep_params
    params.require(:sleep).permit(:start_time, :end_time, :quality, :memo).merge(user_id: current_user.id)
  end

end
