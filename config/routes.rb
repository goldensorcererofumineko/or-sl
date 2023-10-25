Rails.application.routes.draw do
  devise_for :users
  root 'sleepings#index'
  resources :sleepings
end
