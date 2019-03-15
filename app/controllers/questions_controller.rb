class QuestionsController < ApplicationController
  before_action :get_question, only: [:show, :edit, :update, :destroy]

  # GET /question
  # GET /question.json
  def index
    @questions = Question.paginate(:page => params[:page], :per_page => 6)
    @question = Question.new
  end

  # GET /question/1/edit
  def edit
  end

  # POST /question
  # POST /question.json
  def create
    @question = Question.new(question_params)
    respond_to do |format|
      if @question.save
        format.html { redirect_to questions_path, notice: 'Question was successfully created.' }
        format.json { render :show, status: :created, location: @story }
      else
        format.html { redirect_to @question, notice: 'Sonthing was wrong try again.' }

        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    authorize! :create, @question  
    end
  end



  # PATCH/PUT /question/1
  # PATCH/PUT /question/1.json
  def update
    @question.update(question_params)
  end

  # DELETE /question/1
  # DELETE /question/1.json
  def destroy
    @question.destroy
    respond_to do |format|
      format.html { redirect_to questions_path, notice: 'Question was successfully destroyed.' }
      format.json { head :no_content }
      authorize! :create, @question
    end
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