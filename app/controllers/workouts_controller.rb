class WorkoutsController < ApplicationController
  def index
    @workouts = current_user.workouts
    set_current_room
    @message = Message.new
    @messages = current_room.messages if current_room
    @followers = Friendship.where(friend_id: current_user.id)
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
      flash.now[:alert] = "Workout has not been created"
      render :new
    end
  end

  def edit
    @workout = current_user.workouts.find(params[:id])
  end

  def update
    @workout = current_user.workouts.find(params[:id])

    if @workout.update(workout_params)
      flash[:notice] = "Workout has been updated"
      redirect_to [current_user, @workout]
    else
      flash[:alert] = "Workout has not been updated"
      render :edit
    end
  end

  def destroy
    @workout = current_user.workouts.find(params[:id])
    @workout.destroy
    flash[:notice] = "Workout has been deleted"
    redirect_to user_workouts_path(current_user)
  end

  private
    def workout_params
      params.require(:workout).permit(:duration, :workout_type, :date)
    end

    def set_current_room
      if params[:roomId]
        @room = Room.find_by(id: params[:roomId])
      else
        @room = current_user.room
      end
      session[:current_room] = @room.id if @room
    end
end
