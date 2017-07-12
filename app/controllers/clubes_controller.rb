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
