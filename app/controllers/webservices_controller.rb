class WebservicesController < ApplicationController
	
	before_action :check_login, except: [:signin, :signup, :signout]

	def check_login
		if user_signed_in?
			render :json => { :message => 'Faça o seu login para continuar' }, status: 401
		end
	end

end
