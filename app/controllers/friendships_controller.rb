class FriendshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    friend = User.find(params[:friend_id])
    if current_user.friends.include?(friend)
      redirect_to users_path, alert: "Already friends!"
    else
      current_user.friends << friend
      redirect_to users_path, notice: "You are now friends with #{friend.username}"
    end
  end

  def destroy
    friend = User.find(params[:id])
    current_user.friends.delete(friend)
    redirect_to users_path, notice: "You are no longer friends with #{friend.username}"
  end

end
