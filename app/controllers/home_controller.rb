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
	
end