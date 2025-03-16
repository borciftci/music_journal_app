class UsersController < ApplicationController
  before_action :authenticate_user!

  def friends_favorites
    @friends_favorites = current_user.friends.joins(:music_logs).where(music_logs: { favorite: true })
  end
end
