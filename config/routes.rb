Rails.application.routes.draw do
  get 'users/new'

  get 'images/display'
  get 'images/index'
  get 'images/upload'
  get 'images/create'
  post 'images/upload'
  root 'images#index'
  get  '/signup',  to: 'users#new'

  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
