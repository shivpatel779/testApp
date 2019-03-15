class HomesController < ApplicationController
  def index;end

  def import
    authorize! :import, @question
  end

  def import_csv
    User.import(params[:file])
    redirect_to root_url, notice: "Csv file imported."
  end 
end
