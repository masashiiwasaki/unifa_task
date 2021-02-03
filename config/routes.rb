Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :sessions, only: [:new, :create, :destroy]
  resources :pictures, only: [:new, :create]
  get "/oauth/new", to: "oauth#new"
  get "/oauth/callback", to: "oauth#callback"
  root "pictures#index"
end
