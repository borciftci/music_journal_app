Rails.application.routes.draw do
  devise_for :users
  resources :music_logs do
    collection do
      get :export_pdf
    end
  end
  root "music_logs#index"
  get "up" => "rails/health#show", as: :rails_health_check
end
