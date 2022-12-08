Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :merchants, only: [:index, :show] do 
        get '/items', to: 'merchants/items#index'  
      end
    end
  end

  get '/api/v1/items/find_all', to: 'api/v1/items/search#index'
 
  namespace :api do
    namespace :v1 do
      resources :items, only: [:index, :show, :create, :update, :destroy] do 
        get '/merchant', to: 'items/merchant#index'
      end
    end
  end
end
