class ClubesController < ApplicationController
  def index
    @clubes = Clube.all
  end
  
  def new
    @clube = Clube.new
  end

  def edit
  end

  def show
    @clube = Clube.find(params[:id]) rescue nil
  end

  def create
    @clube = Clube.new(clube_params)

    if @clube.save
      render json: { :message => 'Sucesso' }
    else
      render json: { :message => 'Erro' }
    end
  end

  def update
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
end
