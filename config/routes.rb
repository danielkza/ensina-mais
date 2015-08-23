Rails.application.routes.draw do
  root to: 'home#index'

  resources :courses do
    post 'rate', to: :rate
    post 'join', to: :join
    post 'offer', to: :offer
    post 'teach', to: :teach
  end

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }  # The priority is based upon order of creation: first created -> highest priority.
  resources :users, only: [:show, :index]

  get '/industries', to: 'users#industries'
  get '/industries/:id', to: 'users#show'

  get '/students', to: 'users#students'
  get '/students/:id', to: 'users#show'

  get '/teachers', to: 'users#teachers'
  get '/teachers/:id', to: 'users#show'



end
