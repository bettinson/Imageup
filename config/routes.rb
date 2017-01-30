Rails.application.routes.draw do
  get 'sessions/new'

  get 'users/new'

  get 'images/display'
  get 'images/index'
  get 'images/upload'
  get 'images/create'
  post 'images/upload'

  get '/home', to: 'users#feed'
  root 'users#feed'
  delete '/images', to: 'images#destroy'

  get  '/signup',  to: 'users#new'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get '/settings',   to: 'settings#edit'


  resources :users do
    member do
      get :following, :followers
    end
  end

  resources :relationships,       only: [:create, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
