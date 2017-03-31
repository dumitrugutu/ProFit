class WorkoutsController < ApplicationController
  def index
  end

  def new
    @workout = current_user.workouts.new
  end
end
