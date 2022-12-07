Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :merchants, only: [:index, :show] do 
        resources :items, only: [:index]
      end
      resources :items, only: [:index, :show] do
      end
    end
  end
end

# namespace :api do
#   namespace :v1 do
#     resources :merchants, only: [:index, :show] do 
#       get '/items', to: 'merchants/items#index'
#     end
#   end
# end