class SessionsController < ApplicationController

  # function: Login
  # params: email,password
  def create
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      if params[:remember_me]
        cookies.permanent[:user_id] = @user.id
      else
        cookies[:user_id] = { :value => @user.id, :expires => Time.now + 3600}
      end
      redirect_to root_path
    else
      message = "Login is invalid!"
      redirect_to login_path, notice: message
    end
  end

  def new
  end

  # function: logout
  def destroy
    cookies.delete(:user_id)
    redirect_to login_path
  end
end
