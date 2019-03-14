class HomesController < ApplicationController
  def index
  end

  def import
  end

  def import_csv
    User.import(params[:file])
    redirect_to root_url, notice: "Products imported."
  end 
end
