Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :merchants, only: [:index, :show] do 
        get '/items', to: 'merchants/items#index'  
      end
    end
  end

  namespace :api do
    namespace :v1 do
      resources :items, only: [:index, :show, :create, :update, :destroy] do 
        get '/merchant', to: 'items/merchant#index'
      end
    end
  end
end
