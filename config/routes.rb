Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :favorites, only: %i[index create update destroy]
  resources :wishlists, only: %i[index create destroy edit update] do
    patch 'order', on: :collection
  end
  resources :games, only: :show
  get 'suggestions', to: 'suggestions#index'
  get 'wishlists/:id/share', to: 'wishlists#share', as: :share
  get '/moon', to: 'application#moon', as: 'moon'
  get '/sun', to: 'application#sun', as: 'sun'
end
