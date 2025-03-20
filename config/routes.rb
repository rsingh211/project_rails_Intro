Rails.application.routes.draw do
  get "characters/index"
  get "characters/show"
  # Defines the root path
  root "characters#index"

  # About Page Route
  get "/about", to: "pages#about"

  # Health Check Route (optional)
  get "up" => "rails/health#show", as: :rails_health_check
end
