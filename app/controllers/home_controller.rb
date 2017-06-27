class HomeController < ApplicationController
	
	def index
	end

	def entrando
		u = User.where(:cpf => params[:user][:cpf]).first

		if u.nil?
			render json: { :nao => 'Não encontrado' }
		else
			if u.valid_password?(params[:user][:password])
				sign_in u
			else
				render json: { :nao => 'Senha Errada' }
			end
		end
		
	end

end