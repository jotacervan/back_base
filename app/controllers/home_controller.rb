class HomeController < ApplicationController
	before_action :authenticate_user!

	def index
		@users = User.where(:user_type => 'User')
		@questions = Question.all
		@page = 'Home'
	end
	
end