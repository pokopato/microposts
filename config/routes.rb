Rails.application.routes.draw do
  root to: 'static_pages#home'
  get 'signup', to: 'users#new'
  get 'login'     => 'sessions#new'
  post 'login'    => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
  get 'users/:id/following' => 'users#following', as: 'following'
  get 'users/:id/follower'  => 'users#follower',  as: 'follower'
  
  resources :users do 
    member do
      get 'favorites' => 'users#favorite', as: 'favorites'
    end
  end
  resources :relationships, only: [:create, :destroy]
  resources :favoriteships, only: [:create, :destroy]
  resources :sessions, only: [:new, :create, :destroy]
  resources :microposts
end
