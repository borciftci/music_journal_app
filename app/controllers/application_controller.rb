class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  layout :determine_layout

  private

  def determine_layout
    if devise_controller?
      "devise"
    else
      "application"
    end
  end
end
