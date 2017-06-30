Rails.application.routes.draw do

  # ===========================
  # 	  ROOT DEFINITION
  # ===========================
  root to: 'home#index'

  devise_for :users
  apipie

  resources :users
  resources :clubes
  resources :torcidas
  
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
    post '/login/update_address'
    post '/login/complete_login'

    # ===========================
    #        LOGIN METHODS 
    # ===========================
    get  '/account/getAbout'

	  # ===========================
  	# 	   QUESTION METHODS 
  	# ===========================
  	get '/questions/getQuestion'

    # ===========================
    #      TIME METHODS
    # ===========================
    get '/times/getTimes'

    # ===========================
    #      TORCIDAS METHODS 
    # ===========================
    get '/torcidas/getTorcidas'
  end

 
end
