class QuestionsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin
  
  # =================================
  #            INDEX METHOD
  # =================================
  def index
    @questions = Question.all.distinct(:question)
  end

  # =================================
  #           CREATE METHOD
  # =================================
  def create
    @question = Question.new(question_params)

    if @question.save
      redirect_to edit_question_path(@question.id)
    else
      render 'new'
    end

  end

  # =================================
  #       EDIT QUESTION METHOD
  # =================================
  def edit
    @question = Question.find(params[:id])
  end

  # =================================
  #        NEW QUESTION METHOD
  # =================================
  def new
    @question = Question.new
  end

  # =================================
  #      DESTROY QUESTION METHOD
  # =================================
  def destroy
    @question  = Question.find(params[:id]) rescue nil

    if @question.nil?
      redirect_to questions_path
    else
      @question.destroy
      redirect_to questions_path
    end
  end

  # =================================
  #       SHOW QUESTION METHOD
  # =================================
  def show
    @question = Question.find(params[:id]) rescue nil
  end

  # =================================
  #       UPDATE QUESTION METHOD
  # =================================
  def update
    @question = Question.find(params[:id])

    if @question.update(question_params)
      redirect_to edit_question_path(@question.id)
    else
      render 'edit'
    end
  end

  private
    def question_params
      params.require(:question).permit(:question)
    end
end
