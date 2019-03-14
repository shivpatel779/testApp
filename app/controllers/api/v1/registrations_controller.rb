class Api::V1::RegistrationsController < Api::ApiController

respond_to :json
  skip_before_action :verify_authenticity_token
  before_action :check_user, only: [:create]

  def create
    if params[:user][:email].blank? || params[:user][:password].blank? || params[:user][:password_confirmation].blank?
      render json: {status: "failed", message: "Missing parameters"}
    else
      @user = User.new(user_params)
      @user.generate_auth_token!
      image_file = Paperclip.io_adapters.for(params[:user][:picture])
      image_file.original_filename = "#{set_image_name}.png"
      @user.picture = image_file
      if @user.save
        render json: {status: "successful", user: { id: @user.id, email: @user.email, authentication_token: @user.authentication_token, created_at: @user.created_at, updated_at: @user.updated_at,file: @user.picture }}
      else 
        render json: {status: "failed", user: @user.errors}
      end
    end
  end
  private 

  def set_image_name
    random_number = SecureRandom.base64
  end

  def user_params
    params.require(:user).permit(:email,:password,:password_confirmation,:name,:age,:location,:search_radius,:sport_id,:picture)
  end

  def check_user
    if User.exists?(email: params[:user][:email])
      render  json: {status: "failed", message: "User already exists"}
    end
  end
end