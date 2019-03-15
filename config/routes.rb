Rails.application.routes.draw do
  root 'homes#index'
  devise_for :users
  get '/import', :to => 'homes#import' 
  post '/import/csv', :to => 'homes#import_csv'
  resources :questions, only: [:index, :create, :edit, :update, :destroy]
  
  namespace :api do
    namespace :v1 do 
      get '/get_mapping', :to => 'questions#get_mapping'      
      get '/questions', :to => 'questions#index'
      post '/questions', :to => 'questions#create'
      patch 'questions/:id', :to => 'questions#update'
      delete 'questions/:id', :to => 'questions#destroy'
    end
  end

end
