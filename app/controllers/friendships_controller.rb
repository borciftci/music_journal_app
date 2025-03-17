class FriendshipsController < ApplicationController
  before_action :authenticate_user!

  def index
    @friends = current_user.friends
    @pending_friendships = current_user.pending_friendships
  end

  def new
  end

  def set_friends_favorites
    @friends_favorites = current_user.friends.includes(:favorite_song).where.not(favorite_song_id: nil)
  end

  def create
    friend = User.find_by(email: params[:email])

    if friend.nil?
      redirect_to new_friendship_path, alert: "User not found"
    elsif current_user.friends.include?(friend)
      redirect_to friends_path, alert: "Already friends!"
    elsif Friendship.exists?(user: current_user, friend: friend, status: "pending")
      redirect_to friends_path, alert: "Friend request already sent!"
    else
      Friendship.create(user: current_user, friend: friend, status: :pending)
      redirect_to friends_path, notice: "Friend request sent to #{friend.username}"
    end
  end

  def accept
    friendship = Friendship.find(params[:id])

    if friendship.friend == current_user
      friendship.update(status: "accepted")
      Friendship.create(user: friendship.friend, friend: friendship.user, status: "accepted")
      redirect_to friends_path, notice: "Friend request accepted!"
    else
      redirect_to friends_path, alert: "Unauthorized request!"
    end
  end

  def decline
    friendship = Friendship.find(params[:id])

    if friendship.friend == current_user
      friendship.destroy
      redirect_to friends_path, notice: "Friend request declined!"
    else
      redirect_to friends_path, alert: "Unauthorized request!"
    end
  end

  def destroy
    friendship1 = Friendship.find_by(user: current_user, friend_id: params[:id])
    friendship2 = Friendship.find_by(user: params[:id], friend_id: current_user.id)

    if friendship1
      friendship1.destroy
    end

    if friendship2
      friendship2.destroy
    end

    redirect_to friends_path, notice: "You are no longer friends."
  end
end
