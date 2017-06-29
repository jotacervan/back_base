class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.where(:user_type => 'User')
    @page = 'Users'
  end

  def create
  end

  def new
  end

  def edit
  end

  def show
    @user = User.find(params[:id])
  end

  def update
  end

  def destroy
  end
end
