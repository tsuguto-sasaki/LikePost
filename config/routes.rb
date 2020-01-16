Rails.application.routes.draw do
  root to: 'toppages#index'
  
  post 'search', to: 'members#search'
  get 'search', to:'members#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'members#new'
  resources :members, only: [:index, :show, :new, :create] do
    member do
      get :followings
      get :followers
      get :goods
    end
  end
  resources :tweets, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]
  resources :likes, only: [:create, :destroy]
end
