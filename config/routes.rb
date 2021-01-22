Rails.application.routes.draw do
  root to: 'homes#top'
  devise_for :users
  get 'home/about' => 'homes#about'
  resources :books
  resources :users, only: [:show, :edit, :update, :index]
end