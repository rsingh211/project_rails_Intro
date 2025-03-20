Rails.application.routes.draw do
  root "characters#index"

  get "/about", to: "pages#about"

  resources :characters, only: [:index, :show]
  resources :films, only: [:index, :show]
end
