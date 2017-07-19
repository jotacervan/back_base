class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin

  def index
    @users = User.where(:user_type => 'User')
    @page = 'Users'
  end

  def create
  end

  def approve_user
    @user = User.find(params[:id])

    @user.approved_torcida = true
    @user.save(validate: false)
    redirect_to root_path
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
    @user = User.find(params[:id]) rescue nil

    if @user.nil?
      @user.destroy
      redirect_to users_path
    else
      redirect_to users_path, alert: 'Erro ao deletar usuário'
    end
  end
end