class ClubesController < ApplicationController
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
end
