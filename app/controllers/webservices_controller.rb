class WebservicesController < ApplicationController
	skip_before_action :verify_authenticity_token	
	before_action :check_login, except: [:signin, :signup, :update_question, :update_photos, :getTimes, :getTorcidas ]
	
	def check_login
		if !user_signed_in?
			render :json => { :message => 'Faça o seu login para continuar' }, status: 401
		end
	end
	
end
