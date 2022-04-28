Rails.application.routes.draw do
  # resources :items, only: [:index, :show] do 
  #   resources :users, only: [:show]
  # end 
  resources :users, only: [:index, :show] do 
    resources :items, only: [:show, :index, :create ]
  end 
    resources :items, only: [:index]
    
end
