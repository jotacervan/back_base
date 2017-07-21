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
  #        CLUBES ROUTES
  # ===========================
  get 'clubes/new_manager'
  get 'clubes/edit_manager/:id' => 'clubes#edit_manager', as: :edit_clube_admin
  delete 'clubes/destroy_manager/:id' => 'clubes#destroy_manager', as: :destroy_clube_manager
  post 'create_clubes_manager' => 'clubes#create_manager', as: :create_clubes_manager
  post 'edit_clubes_manager' => 'clubes#edit_clubes_manager', as: :edit_clubes_manager
  get 'clube_active/:id' => 'clubes#active', as: :clube_active
  get 'clube_desactive/:id' => 'clubes#desactive', as: :clube_desactive
  get 'clube_admins' => 'clubes#admins', as: :clube_admins

  # ===========================
  #        TORCIDAS ROUTES
  # ===========================
  get 'torcidas/new_manager'
  get 'torcidas/edit_manager/:id' => 'torcidas#edit_manager', as: :edit_torcida_admin
  delete 'torcidas/destroy_manager/:id' => 'torcidas#destroy_manager', as: :destroy_torcida_manager
  post 'create_torcida_manager' => 'torcidas#create_manager', as: :create_torcida_manager
  post 'edit_torcida_manager' => 'torcidas#edit_torcida_manager', as: :edit_torcida_manager
  get 'torcida_active/:id' => 'torcidas#active', as: :torcida_active
  get 'torcida_desactive/:id' => 'torcidas#desactive', as: :torcida_desactive
  get 'torcida_admins' => 'torcidas#admins', as: :torcida_admins

  # ===========================
  #        USERS ROUTES
  # ===========================
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