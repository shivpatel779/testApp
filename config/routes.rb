Rails.application.routes.draw do
  root 'homes#index'
  devise_for :users
  get '/import', :to => 'homes#import' 
  post '/import/csv', :to => 'homes#import_csv'
  resources :questions


  namespace :api do
    namespace :v1 do      
      get '/questions', :to => 'questions#index'
      post '/question', :to => 'questions#create'
    end
  end

end
