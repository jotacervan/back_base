class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  # ========================================
  #           CHECK ADMIN METHOD
  # ========================================
  def check_admin
  	if current_user.user_type == 'superUser'
  				
  	elsif current_user.user_type == 'torcidaUser'
      if request.fullpath != '/torcida_dash'
        redirect_to torcida_dash_path
      end
  	elsif current_user.user_type == 'clubeUser'
      if request.fullpath != '/time_dash'
        redirect_to time_dash_path
      end
  	else
  		sign_out current_user
  		redirect_to root_path
  	end
  end
end
