class FriendshipsController < ApplicationController
  before_action :authenticate_user!

  def show
    @friend = Friendship.find_by(friend_id: params[:id]).friend
    @workouts = @friend.workouts
  end

  def create
    friend = User.find(params[:friend_id])
    params[:user_id] = current_user.id

    Friendship.create(friendship_params) unless current_user.follows_or_same?(friend)
    redirect_to root_path
  end

  def destroy
    @friendship = Friendship.find_by(friend_id: params[:id])
    friend_name = @friendship.friend.full_name

    if @friendship.destroy
      flash[:notice] = "You have unfollowed #{friend_name} successfully"
    else
      flash.now[:alert] = "#{friend_name} could not be unfollowed"
    end
    redirect_to root_path
  end

  private
    def friendship_params
      params.permit(:friend_id, :user_id)
    end
end
