Rails.application.routes.draw do

  # ===========================
  # 	    ROOT DEFINITION
  # ===========================
  root to: 'home#index'

  devise_for :users
  apipie

  # ===========================
  #      DASHBOARDS ROUTES
  # ===========================
  get 'torcida_dash' => 'home#torcida_dash', as: :torcida_dash
  get 'time_dash' => 'home#time_dash', as: :time_dash

  # ===========================
  #     NEW MANAGERS ROUTES
  # ===========================
  get 'torcidas/new_manager'
  get 'clubes/new_manager'
  post 'create_torcida_manager' => 'torcidas#create_manager', as: :create_torcida_manager
  post 'create_clubes_manager' => 'clubes#create_manager', as: :create_clubes_manager
  get 'approve_user/:id' => 'user#approve', as: :approve_user

  # ===========================
  #         RESOURCES
  # ===========================
  resources :users
  resources :clubes
  resources :torcidas
  resources :questions
  
  # ===========================
  # 	      WEBSERVICES
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
    #       ACCOUNT METHODS 
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