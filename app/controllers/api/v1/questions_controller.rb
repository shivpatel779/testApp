class Api::V1::QuestionsController < Api::ApiController

  respond_to :json
  skip_before_action :verify_authenticity_token
  
  def index
    @questions = Question.all
    render json: @questions
  end

  def create
    if params[:question][:pri].blank? || params[:question][:frequency].blank? || params[:question][:mapping_id].blank? || params[:question][:question].blank?
      render json: {status: "failed", message: "Missing parameters"}
    else
      @question = Question.new(question_params)
      if @question.save
        render json: {status: "successful", question: { id: @question.id, pri: @question.pri, teaming_stages: @question.teaming_stages,appears_day: @question.appears_day, frequency: @question.frequency,question_type: @question.question_type ,required?: @question.required?, conditions: @question.conditions ,created_at: @question.created_at, updated_at: @question.updated_at }}
      else 
        render json: {status: "failed", question: @question.errors}
      end
    end
  end

  def update
  end

  def destroy
  end

  private

  def question_params
    params.require(:question).permit(:pri, :question, :teaming_stages, :appears_day, :frequency, :question_type, :conditions, :mapping_id, :required?)
  end
  
end