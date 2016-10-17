Rails.application.routes.draw do
  get 'images/display'
  get 'images/index'
  get 'images/upload'
  get 'images/create'
  post 'images/create'
  root 'images#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
