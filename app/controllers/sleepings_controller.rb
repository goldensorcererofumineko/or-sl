class SleepingsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_sleep, only: [:show, :edit, :update, :destroy]
  def index
    @sleepings = Sleeping.all

  end

  def show
  end

  def new
    @Sleeping = Sleeping.new
  end

  def create
    @sleepings = Sleeping.new(sleep_params)
    if @sleepings.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    @Sleeping = Sleeping.find(params[:id])
    if sleep.update(sleep_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    @Sleeping = Sleeping.find(params[:id])
    Sleeping.destroy
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
