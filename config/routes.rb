Rails.application.routes.draw do
  resources :posts
  devise_for :users
  root "hello#index"
end
