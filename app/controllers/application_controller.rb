class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def check_admin
  	if current_user.user_type != 'superUser'
  				
  	end
  end
end