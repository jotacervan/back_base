class QuestionsController < ApplicationController
  def index
    @questions = Question.all
  end

  def create
    @question = Question.new(question_params)

    if @question.save
      redirect_to @question
    else
      render 'new'
    end

  end

  def edit
    @question = Question.find(params[:id])
  end

  def new
    @question = Question.new
  end

  def destroy
    @question  = Question.find(params[:id]) rescue nil

    if @question.nil?
      redirect_to questions_path
    else
      @question.destroy
      redirect_to questions_params
    end
  end

  def show
    @question = Question.find(params[:id]) rescue nil
  end

  def update
    @question = Question.find(params[:id])

    if @question.update(question_params)
      redirect_to @question
    else
      render 'edit'
    end
  end

  private
    def question_params
      params.require(:question).permit(:question)
    end
end
