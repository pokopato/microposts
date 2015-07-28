Rails.application.routes.draw do
  root to: 'static_pages#home'
  get 'signup', to: 'users#new'
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
  get 'following' => 'users#following'
  get 'follower' => 'users#follower'
  
  resources :users
  resources :relationships, only: [:create, :destroy]
  resources :sessions, only: [:new, :create, :destroy]
  resources :microposts
end
