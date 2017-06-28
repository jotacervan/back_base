Rails.application.routes.draw do
  
  root to: 'home#index'

  devise_for :users
  apipie

  namespace :webservices do
	post '/login/signin'
	post '/login/signup'
	post '/login/update_photos'
	post '/login/update_question'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
