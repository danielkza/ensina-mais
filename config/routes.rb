Rails.application.routes.draw do
  root to: 'home#index'

  resources :courses

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }  # The priority is based upon order of creation: first created -> highest priority.
  resources :users, only: [:show, :index]

end
