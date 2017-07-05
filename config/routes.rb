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
  resources :questions
  
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
    post '/login/set_payment'
    
    # ===========================
    #        LOGIN METHODS 
    # ===========================
    get  '/account/getAbout'

	  # ===========================
  	# 	   QUESTION METHODS 
  	# ===========================
  	get  '/questions/getQuestion'
    post '/questions/checkQuestion'
    
    # ===========================
    #        TIME METHODS
    # ===========================
    get  '/times/getTimes'

    # ===========================
    #      TORCIDAS METHODS 
    # ===========================
    get  '/torcidas/getTorcidas'
  end

 
end
