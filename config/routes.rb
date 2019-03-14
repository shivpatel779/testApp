Rails.application.routes.draw do
  root 'homes#index'
  devise_for :users
  get '/import', :to => 'homes#import' 
  post '/import/csv', :to => 'homes#import_csv'
  resources :questions
end
