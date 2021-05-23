class ApplicationController < ActionController::Base
  helper_method :logged_in?, :current_user

  def current_user
    if cookies[:user_id]
      # decode = JWT.decode(cookies[:user_id], 'yourSecret', true, algorithm: 'HS256')
      decode = decoded_token(cookies[:user_id])
      if !decode.present?
        redirect_to login_path, notice: "Authorization is not correct."
      else
        hash = HashWithIndifferentAccess.new(decode[0])
        @user = User.find(hash[:user_id])
      end
    end
  end

  def logged_in?
    !!current_user
  end

  def authorized
    redirect_to login_path unless logged_in?
  end

  # def authenticate
  #   if request.headers["Authorization"]
  #     begin
  #       auth_header =  request.headers["Authorization"]
  #       decode_token = JWT.decode(token, secret)
  #       payload = decode_token.first
  #       user_id = payload["user_id"]
  #       @user = User.find(user_id)
  #     rescue => exception
  #       render json: { message: "Error #{exception}"}, status: :forbidden
  #   else
  #     render json: { message: "No authorization header sent"}, status: :forbidden
  #   end
  # end

  # def secret
  #   secret = ENV['SECRET_KEY_BASE'] || Rails.application.secrets.secret_key_base
  # end

  # def token
  #   auth_header.split(" ")[1]
  # end

  # def create_token(payload)
  #   JWT.encode(payload, secret)
  # end

  def encode_token(payload)
    JWT.encode(payload, 'yourSecret')
  end

  def auth_header
    # { Authorization: 'Bearer <token>' }
    request.headers['Authorization']
  end

  def decoded_token(token)
    # token = auth_header.split(' ')[1]
    # header: { 'Authorization': 'Bearer <token>' }
    begin
      JWT.decode(token, 'yourSecret', true, algorithm: 'HS256')
    rescue JWT::DecodeError
      nil
    end
  end
end
