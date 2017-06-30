class TorcidasController < ApplicationController
  def index
    @torcidas = Torcida.all
  end

  def new
    @torcida = Torcida.new
    @clubes = Clube.all
  end
  
  def edit
  end

  def show
  end

  def create
    @torcida = Torcida.new(torcida_params)

    if @torcida.save
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
    def torcida_params
      params.require(:torcida).permit(:name,:picture,:clube_id)
    end
end
