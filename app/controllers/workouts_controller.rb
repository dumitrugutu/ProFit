class WorkoutsController < ApplicationController
  def index
  end

  def show
    @workout = current_user.workouts.find(params[:id])
  end

  def new
    @workout = current_user.workouts.new
  end

  def create
    @workout = current_user.workouts.new(workout_params)

    if @workout.save
      flash[:notice] = "Workout has been created"
      redirect_to [current_user, @workout]
    else
      flash[:alert] = "Workout has not been created"
      render :new
    end
  end

  private
    def workout_params
      params.require(:workout).permit(:duration, :workout_type, :date)
    end
end
