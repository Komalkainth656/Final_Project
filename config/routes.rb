Rails.application.routes.draw do
   root 'recipes#index'
   resources :users, only: [:new, :create]
   resource :session, only: [:new, :create, :destroy] 

   resources :recipes do
   resources :comments, only: [:create, :destroy]
   end

end