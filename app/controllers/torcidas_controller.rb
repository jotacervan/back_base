class TorcidasController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin

  def index
    @torcidas = Torcida.all
  end

  def new
    @torcida = Torcida.new
    @clubes = Clube.all
  end

  def edit
    @torcida = Torcida.find(params[:id])
    @clubes = Clube.all
  end

  def show
  end
  
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
  
  def desactive
    @torcida = Torcida.find(params[:id])
    if @torcida.update(:active => 0)
      redirect_to torcidas_path, notice: 'Torcida desativada com sucesso'
    else
      redirect_to torcidas_path, alert: 'Não foi possivel desativar a torcida, tente novamente mais tarde'
    end
  end

  def new_manager
    @torcidas = Torcida.all
  end

  def create_manager
    @def = User.new(manager_params)

    if @def.save(validate: false)
      redirect_to users_path, notice: 'Administrador criado com sucesso'
    else
      redirect_to users_path, alert: 'Erro ao criar administrador'
    end

  end

  def create
    @torcida = Torcida.new(torcida_params)

    if @torcida.save
      redirect_to edit_torcida_path(@torcida.id)
    else
      render 'new'
    end
  end

  def update
    @torcida = Torcida.find(params[:id])

    if @torcida.update(torcida_params)
      redirect_to edit_torcida_path(@torcida.id)
    else
      render 'new'
    end
  end

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
