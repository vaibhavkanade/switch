require 'sidekiq/web'

Rails.application.routes.draw do

  resources :appliances do
    member do
      patch 'toggle'
    end
  end

  mount Sidekiq::Web => '/sidekiq'
  root 'appliances#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
