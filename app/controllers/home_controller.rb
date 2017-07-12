class HomeController < ApplicationController
	before_action :authenticate_user!
	before_action :check_admin

	def index
		@users = User.where(:user_type => 'User')
		@questions = Question.all
		@clubes = Clube.all
		@torcidas = Torcida.all
		@backlog = Backlog.all.order(created_at: :desc)
		@page = 'Home'
	end

	def torcida_dash
		@users = User.where(:user_type => 'User',:torcida_id => current_user.torcida_id)
		@page = 'Home'
	end
	
	def time_dash
		@users = User.where(:user_type => 'User')
		@questions = Question.all
		@clubes = Clube.all
		@torcidas = Torcida.all
		@backlog = Backlog.all.order(created_at: :desc)
		@page = 'Home'
	end

end