class TorcidasController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin

  # =================================
  #      INDEX TORCIDAS METHOD
  # =================================
  def index
    @torcidas = Torcida.all
  end
  
  # =================================
  #        TORCIDA NEW METHOD
  # =================================
  def new
    @torcida = Torcida.new
    @clubes = Clube.all
  end

  # =================================
  #       EDIT TORCIDA METHOD
  # =================================
  def edit
    @torcida = Torcida.find(params[:id])
    @clubes = Clube.all
  end

  # =================================
  #        SHOW TORCIDA METHOD
  # =================================
  def show
  end

  # =================================
  #        SHOW ADMINS METHOD
  # =================================
  def admins
    @users = User.where(:user_type => 'torcidaUser')
  end
  
  # =================================
  #      ACTIVATE TORCIDA METHOD
  # =================================
  def active
    @torcida = Torcida.find(params[:id])

    if @torcida.clube.active > 0
      if @torcida.update(:active => 1)
        redirect_to torcidas_path, notice: 'Torcida ativada com sucesso'
      else
        redirect_to torcidas_path, alert: 'Não foi possivel ativar o torcida, tente novamente mais tarde'
      end
    else
      redirect_to torcidas_path, alert: 'Time inteiro está desativado, para completar essa ação ative o time primeiro!'
    end
  end
  
  # =================================
  #     DESACTIVATE TORCIDA METHOD
  # =================================
  def desactive
    @torcida = Torcida.find(params[:id])
    if @torcida.update(:active => 0)
      redirect_to torcidas_path, notice: 'Torcida desativada com sucesso'
    else
      redirect_to torcidas_path, alert: 'Não foi possivel desativar a torcida, tente novamente mais tarde'
    end
  end

  # =================================
  #      NEW MANAGER VIEW METHOD
  # =================================
  def new_manager
    @torcidas = Torcida.all
  end

  # =================================
  #      CREATE MANAGER METHOD
  # =================================
  def create_manager
    @def = User.new(manager_params)

    if @def.save(validate: false)
      redirect_to torcida_admins_path, notice: 'Administrador criado com sucesso'
    else
      redirect_to torcida_admins_path, alert: 'Erro ao criar administrador'
    end

  end

  # =================================
  #       CREATE TORCIDA METHOD
  # =================================
  def create
    @torcida = Torcida.new(torcida_params)

    if @torcida.save
      redirect_to edit_torcida_path(@torcida.id)
    else
      render 'new'
    end
  end

  # =================================
  #      EDIT MANAGER VIEW METHOD
  # =================================
  def edit_manager
    @torcidas = Torcida.all
    @manager = User.find(params[:id])
  end

  # =================================
  #      DESTROY MANAGER METHOD
  # =================================
  def destroy_manager
    @user = User.find(params[:id])

    if @user.destroy
      redirect_to torcida_admins_path, notice: 'Administrador deletado com sucesso'
    else
      redirect_to torcida_admins_path, alert: 'Não foi possivel deletar o administrador'
    end
  end

  # =================================
  #       EDIT TORCIDA METHOD
  # =================================
  def edit_torcida_manager
    @def = User.find(params[:manager][:id])

    params[:manager][:name].blank? ? '' : @def.name = params[:manager][:name]
    params[:manager][:email].blank? ? '' : @def.email = params[:manager][:email]
    params[:manager][:cpf].blank? ? '' : @def.cpf = params[:manager][:cpf]
    params[:manager][:password].blank? ?  '' : @def.password = params[:manager][:password]
    params[:manager][:password_confirmation].blank? ? ''  : @def.password_confirmation = params[:manager][:password_confirmation]
    params[:manager][:torcida_id].blank? ? '' : @def.torcida_id = params[:manager][:torcida_id]

    if @def.save(validate: false)
      redirect_to torcida_admins_path, notice: 'Administrador editado com sucesso'
    else
      redirect_to torcida_admins_path, alert: 'Erro ao criar administrador'
    end
  end

  # =================================
  #      UPDATE TORCIDA METHOD
  # =================================
  def update
    @torcida = Torcida.find(params[:id])

    if @torcida.update(torcida_params)
      redirect_to edit_torcida_path(@torcida.id)
    else
      render 'new'
    end
  end

  # =================================
  #      DESTROY TORCIDA METHOD
  # =================================
  def destroy
    @torcida = Torcida.find(params[:id])

    if @torcida.destroy
      redirect_to torcidas_path
    else
      redirect_to torcidas_path
    end
  end

  private
    def torcida_params
      params.require(:torcida).permit(:name,:picture,:clube_id)
    end

    def manager_params
      params.require(:manager).permit(:name,:email,:cpf,:password,:password_confirmation,:torcida_id,:user_type)
    end
end
