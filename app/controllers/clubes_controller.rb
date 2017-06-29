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
  end

  private
    def clube_params
      params.require(:clube).permit(:name,:picture)
    end
end
