class HomeController < ApplicationController
	before_action :authenticate_user!

	def index
		@users = User.where(:user_type => 'User')
		@questions = Question.all
		@backlog = Backlog.all.order(created_at: :desc)
		@page = 'Home'
	end
	
end