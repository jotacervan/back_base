class ClubesController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin

  def index
    @clubes = Clube.all
  end
  
  def new
    @clube = Clube.new
  end

  def edit
    @clube = Clube.find(params[:id])
  end
  
  def show
    @clube = Clube.find(params[:id]) rescue nil
  end

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

  def new_manager
    @clubes = Clube.all
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
    @clube = Clube.new(clube_params)

    if @clube.save
      redirect_to edit_clube_path(@clube.id)
    else
      render 'new'
    end
  end

  def update
    @clube = Clube.find(params[:id])

    if @clube.update(clube_params)
      redirect_to edit_clube_path(@clube.id)
    else
      render 'edit'
    end
  end

  def destroy
    @clube = Clube.find(params[:id]) rescue nil

    if @clube.nil?
      redirect_to clubes_path
    else
      @clube.destroy
      redirect_to clubes_path
    end
  end

  private
    def clube_params
      params.require(:clube).permit(:name,:picture)
    end
    
    def manager_params
      params.require(:manager).permit(:name,:email,:cpf,:password,:password_confirmation,:torcida_id,:user_type)
    end
end
