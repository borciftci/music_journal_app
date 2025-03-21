Rails.application.routes.draw do
  devise_for :users
  resources :friendships, only: [ :new, :create, :destroy ] do
    member do
      patch :accept
      patch :decline
    end
  end

  resources :music_logs do
    collection do
      get :export_pdf
    end
    member do
      patch :favorite
    end
  end

  require "sidekiq/web"
  authenticate :user, ->(u) { u.admin? } do
    mount Sidekiq::Web => "/sidekiq"
  end

  root "music_logs#index"
  get "friends", to: "friendships#index"
  get "friends_favorites", to: "users#friends_favorites"
  get "up" => "rails/health#show", as: :rails_health_check
end
