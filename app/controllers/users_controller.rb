class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin
  
  # =================================
  #     VIEW ALL APP USERS METHOD
  # =================================
  def index
    @users = User.where(:user_type => 'User')
    @page = 'Users'
  end

  # =================================
  #      TORCIDA DASHBOARD METHOD
  # =================================
  def create
  end

  # =================================
  #       APPROVE USER METHOD
  # =================================
  def approve_user
    @user = User.find(params[:id])

    @user.approved_torcida = true
    @user.save(validate: false)
    redirect_to root_path
  end

  # =================================
  #           SHOW USER
  # =================================
  def show
    @user = User.find(params[:id])
  end

  # =================================
  #      DESTROY USER METHOD
  # =================================
  def destroy
    @user = User.find(params[:id]) rescue nil

    if !@user.nil?
      @user.destroy
      redirect_to users_path
    else
      redirect_to users_path, alert: 'Erro ao deletar usuário'
    end
  end
end