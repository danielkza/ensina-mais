Rails.application.routes.draw do
  root to: 'home#index'

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }  # The priority is based upon order of creation: first created -> highest priority.
end
