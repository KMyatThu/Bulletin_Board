class SessionsController < ApplicationController

  # function: Login
  # params: email,password
  def create
    @user = User.find_by(email: params[:email])
    if !@user
      message = "Email not Exits"
      redirect_to login_path, notice: message
    elsif @user && @user.authenticate(params[:password])
      if params[:remember_me]
        cookies.permanent[:user_id] = @user.id
      else
        cookies[:user_id] = { :value => @user.id, :expires => Time.now + 3600}
      end
      redirect_to root_path
    else
      message = "Incorrect Password!"
      redirect_to login_path, notice: message
    end
  end

  def new
  end

  def login

  end

  def show

  end

  # function: logout
  def destroy
    cookies.delete(:user_id)
    redirect_to login_path
  end

  # function: sign_up form
  def sign_up
    @user = User.new
  end

  # function: create_account (new sign_up)
  # params: user_params(sing_up params)
  def create_account
    @user = User.new(user_params)
    if !@user.valid?
      render :sign_up
    elsif @user.save!
      redirect_to :url => "login", :method => "post", email: @user.email, password: @user.password 
    else
      render :sign_up
    end
  end

  
  private
  # User params
  def user_params
    params.require(:user).permit(:id, :name, :email, :password, :password_confirmation, :role, :phone, :dob, :profile, :create_user_id, :updated_user_id)
  end
end
