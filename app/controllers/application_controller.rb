class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  layout :determine_layout
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!
  before_action :set_friends_favorites
  add_flash_types :success, :error, :info, :warning

  private

  def determine_layout
    if devise_controller?
      "devise"
    else
      "application"
    end
  end

  def set_friends_favorites
    if user_signed_in?
      @friends_favorites = current_user.friends.includes(:favorite_song).where.not(favorite_song_id: nil)
    else
      @friends_favorites = []
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :username ])
    devise_parameter_sanitizer.permit(:account_update, keys: [ :username ])
  end
end
