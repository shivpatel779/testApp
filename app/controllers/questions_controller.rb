class QuestionsController < ApplicationController
  before_action :get_question, only: [:show, :edit, :update, :destroy]

  def index
    @questions = Question.order("id ASC").paginate(:page => params[:page], :per_page => 6)
    @question = Question.new
  end

  def edit;end

  def create
    authorize! :create, @question
    @question = Question.new(question_params)
    if @question.save
      redirect_to questions_path, notice: 'Question was successfully created.'
    else
      redirect_to @question, notice: 'Something was wrong try again.'
    end  
  end

  def update
    authorize! :update, @question
    @question.update(question_params)
  end

  def destroy
    authorize! :destroy, @question
    @question.destroy
    redirect_to questions_path, notice: 'Question was successfully destroyed.'
  end


  private

  # Use callbacks to share common setup or constraints between actions.
  def get_question
    @question = Question.find(params[:id])
  end


  # Never trust parameters from the scary internet, only allow the white list through.
  def question_params
    params.require(:question).permit(:pri, :question, :teaming_stages, :appears_day, :frequency, :question_type, :conditions, :mapping_id, :required?)
  end
end