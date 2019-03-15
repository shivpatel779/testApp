class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  rescue_from CanCan::AccessDenied do |exception|
    flash[:warning] = "You are not authorized to perform this action!"
    redirect_to root_path
  end
end
