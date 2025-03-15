Rails.application.routes.draw do
  devise_for :users
  resources :friendships, only: [ :create, :destroy ]

  resources :music_logs do
    collection do
      get :export_pdf
    end
    member do
      patch :favorite
    end
  end

  root "music_logs#index"
  get "friends_favorites", to: "users#friends_favorites"
  get "up" => "rails/health#show", as: :rails_health_check
end
