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
  end

  def update
  end

  def destroy
  end
end
