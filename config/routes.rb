Rails.application.routes.draw do
  
  # ===========================
  # 	  ROOT DEFINITION
  # ===========================
  root to: 'home#index'

  devise_for :users
  apipie
  
  # ===========================
  # 	    WEBSERVICES
  # ===========================
  namespace :webservices do
  	# ===========================
  	# 	     LOGIN METHODS 
  	# ===========================
	post '/login/signin'
	post '/login/signup'
	post '/login/update_photos'
	post '/login/update_question'

  end

 
end
