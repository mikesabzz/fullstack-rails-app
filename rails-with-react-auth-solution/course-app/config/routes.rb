Rails.application.routes.draw do
  resources :users
  post '/auth/login', to: 'authentication#login'
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :instructors
end
