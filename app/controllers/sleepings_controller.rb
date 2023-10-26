class SleepingsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_sleep, only: [:show, :edit, :update, :destroy]

  def index
    @sleepings = Sleeping.all
    if @sleepings.present? 
      total_sleep_duration = @sleepings.sum { |sleeping| sleeping.sleep_duration.to_i }
      average_sleep_duration_minutes = total_sleep_duration.to_f / @sleepings.length  # 平均の合計分数
      @average_sleep_duration_hours = (average_sleep_duration_minutes / 60).to_i  # 時間（整数部分）
      @average_sleep_duration_minutes = (average_sleep_duration_minutes % 60).to_i  # 分（余り）      
    else
      @average_sleep_duration_hours = 0
      @average_sleep_duration_minutes = 0
    end
  end

  def show
  end

  def new
    @sleeping = Sleeping.new
  end

  def create
    @sleeping = Sleeping.new(sleep_params)  
    if @sleeping.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    @sleeping = Sleeping.find(params[:id])  # Use @sleeping, not sleep
    if @sleeping.update(sleep_params)  # Use @sleeping, not sleep
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
    @sleeping = Sleeping.find(params[:id])  # Use @sleeping, not @Sleeping
  end

  def sleep_params
    params.require(:sleeping).permit(:start_time, :end_time, :quality, :memo).merge(user_id: current_user.id)
  end
end
