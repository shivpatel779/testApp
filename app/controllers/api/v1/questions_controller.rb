class Api::V1::QuestionsController < Api::ApiController
  before_action :get_question, only: [:update, :destroy]

  respond_to :json
  skip_before_action :verify_authenticity_token
  
  def index
    @questions = Question.order("id ASC").paginate(:page => params[:page], :per_page => 10)
    render json: {questions: @questions, total: @questions.count }
  end

  def create
    if missing_parameters?
      render json: {status: "failed", message: "Missing parameters"}
    else
      @question = Question.new(question_params)
      if @question.save
        render json: @question
      else 
        render json: {status: "failed", question: @question.errors}
      end
    end
  end

  def update
    @question.update(question_params)
    render json: {status: "ok", question: @question}
  end

  def destroy
    @question.destroy
    render json: {status: "ok", message: "question sucessfully delete" }
  end

  def get_mapping
    @mapping =  Mapping.all.map{|mapping| {id: mapping.id, name: mapping.name} }
    render json: @mapping
  end

  private

  def question_params
    params.require(:question).permit(:pri, :question, :teaming_stages, :appears_day, :frequency, :question_type, :conditions, :mapping_id, :required?)
  end
  
  def missing_parameters?
    params[:question][:pri].blank? || params[:question][:frequency].blank? || params[:question][:mapping_id].blank? || params[:question][:question].blank?
  end

  def get_question
    @question = Question.find(params[:id])
  end 
end