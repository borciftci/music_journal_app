class FriendshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    friend = User.find(params[:friend_id])

    if current_user.friends.include?(friend)
      redirect_to users_path, alert: "Already friends!"
    elsif Friendship.exists?(user: current_user, friend: friend, status: :pending)
      redirect_to users_path, alert: "Friend request already sent!"
    else
      Friendship.create(user: current_user, friend: friend, status: :pending)
      redirect_to users_path, notice: "Friend request sent to #{friend.username}"
    end
  end

  def accept
    friendship = Friendship.find(params[:id])
    if friendship.friend == current_user
      friendship.update(status: :accepted)
      Friendship.create(user: friendship.friend, friend: friendship.user, status: :accepted)
      redirect_to users_path, notice: "Friend request accepted!"
    else
      redirect_to users_path, alert: "Unauthorized request!"
    end
  end

  def decline
    friendship = Friendship.find(params[:id])

    if friendship.friend == current_user
      friendship.update(status: :declined)
      redirect_to users_path, notice: "Friend request declined!"
    else
      redirect_to users_path, alert: "Unauthorized request!"
    end
  end

  def destroy
    friendship = Friendship.find_by(user: current_user, friend_id: params[:id]) ||
      Friendship.find_by(friend: current_user, user_id: params[:id])

    if friendship
      friendship.destroy
      redirect_to users_path, notice: "You are no longer friends"
    else
      redirect_to users_path, alert: "Friendship not found"
    end
  end
end
