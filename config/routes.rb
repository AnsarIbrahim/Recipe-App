Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # root to: redirect('/users/sign_up')
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  resources :recipes ,only: [:create, :index, :destroy, :show, :new, :update] do
    member do
      patch 'update_privacy', to: 'recipes#updatePrivacy', as: 'update_recipe_privacy'
    end
  end

  resources :recipe_foods, only: [:new, :create, :destroy]
  
  resources :inventories, only: [:create, :index, :show, :destroy, :new] do
    resources :inventory_foods, only: [:new, :create, :destroy]
  end

  resources :inventory_foods do
    delete 'remove_food', on: :member
  end
    
  get '/public_recipes', to:'recipes#public_recipes', as: :public_recipes
  get '/shopping_list', to:'recipes#shopping_list', as: :shopping_list

  devise_for :users, controllers: {
        registrations: 'users/registrations',
        confirmations: 'users/confirmations'
  }
  
  resources :foods, only: [:index, :create, :destroy, :new]

  devise_scope :user do
    get '/users/sign_out', to: 'devise/sessions#destroy'
    # destroy_user_session_path << Required Later
    # root to: 'recipes#public_recipes' << Required Later
  end
  
  # devise_for :users
  # Defines the root path route ("/")
  root "recipes#public_recipes"
end
