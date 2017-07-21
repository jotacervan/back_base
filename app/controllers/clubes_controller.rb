class ClubesController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin
  # ==============================
  #             INDEX
  # ==============================
  def index
    @clubes = Clube.all
  end
  
  # ==============================
  #               NEW
  # ==============================
  def new
    @clube = Clube.new
  end

  # ==============================
  #             EDIT
  # ==============================
  def edit
    @clube = Clube.find(params[:id])
  end

  # ==============================
  #             SHOW
  # ==============================
  def show
    @clube = Clube.find(params[:id]) rescue nil
  end

  # ==============================
  #             ADMINS
  # ==============================
  def admins
    @users = User.where(:user_type => 'clubeUser')
  end

  # ==============================
  #            ACTIVE
  # ==============================
  def active
    @clube = Clube.find(params[:id])
    if @clube.update(:active => 1)
      @clube.torcidas.each do |t|
        t.update(:active => 1)
      end
      redirect_to clubes_path, notice: 'Clube ativado com sucesso'
    else
      redirect_to clubes_path, alert: 'Não foi possivel ativar o clube, tente novamente mais tarde'
    end
  end
  
  # ==============================
  #           DESACTIVE
  # ==============================
  def desactive
    @clube = Clube.find(params[:id])
    if @clube.update(:active => 0)
      @clube.torcidas.each do |t|
        t.update(:active => 0)
      end
      redirect_to clubes_path, notice: 'Clube desativado com sucesso'
    else
      redirect_to clubes_path, alert: 'Não foi possivel desativar o clube, tente novamente mais tarde'
    end
  end

  # ==============================
  #         NEW MANAGER
  # ==============================
  def new_manager
    @clubes = Clube.all
  end

  # ==============================
  #         CREATE MANAGER
  # ==============================
  def create_manager

    @def = User.new(manager_params)

    if @def.save(validate: false)
      redirect_to clube_admins_path, notice: 'Administrador criado com sucesso'
    else
      redirect_to clube_admins_path, alert: 'Erro ao criar administrador'
    end
    
  end

  # ==============================
  #       EDIT CLUBES MANAGER
  # ==============================
  def edit_clubes_manager
    @def = User.find(params[:manager][:id])

    params[:manager][:name].blank? ? '' : @def.name = params[:manager][:name]
    params[:manager][:email].blank? ? '' : @def.email = params[:manager][:email]
    params[:manager][:cpf].blank? ? '' : @def.cpf = params[:manager][:cpf]
    params[:manager][:password].blank? ?  '' : @def.password = params[:manager][:password]
    params[:manager][:password_confirmation].blank? ? ''  : @def.password_confirmation = params[:manager][:password_confirmation]
    params[:manager][:torcida_id].blank? ? '' : @def.torcida_id = params[:manager][:torcida_id]

    if @def.save(validate: false)
      redirect_to clube_admins_path, notice: 'Administrador editado com sucesso'
    else
      redirect_to clube_admins_path, alert: 'Erro ao criar administrador'
    end
  end

  # ==============================
  #           EDIT MANAGER
  # ==============================
  def edit_manager
    @clubes = Clube.all
    @manager = User.find(params[:id])
  end

  # ==============================
  #       DESTROY MANAGER
  # ==============================
  def destroy_manager
    @manager = User.find(params[:id])

    @manager.destroy

    redirect_to clube_admins_path
  end

  # ==============================
  #             CREATE
  # ==============================
  def create
    @clube = Clube.new(clube_params)

    if @clube.save
      redirect_to edit_clube_path(@clube.id)
    else
      render 'new'
    end
  end

  # ==============================
  #             UPDATE
  # ==============================
  def update
    @clube = Clube.find(params[:id])

    if @clube.update(clube_params)
      redirect_to edit_clube_path(@clube.id)
    else
      render 'edit'
    end
  end

  # ==============================
  #             DESTROY
  # ==============================
  def destroy
    @clube = Clube.find(params[:id]) rescue nil

    if @clube.nil?
      redirect_to clubes_path
    else
      @clube.destroy
      redirect_to clubes_path
    end
  end

  # ==============================
  #             PRIVATE
  # ==============================
  private
    def clube_params
      params.require(:clube).permit(:name,:picture)
    end
    
    def manager_params
      params.require(:manager).permit(:name,:email,:cpf,:password,:password_confirmation,:torcida_id,:user_type)
    end
end
