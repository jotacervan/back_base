class TorcidasController < ApplicationController
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
end
