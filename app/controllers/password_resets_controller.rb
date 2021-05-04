class PasswordResetsController < ApplicationController
  def new
  end

  # function: create(reset Password)
  # params: email
  def create
    user = User.find_by_email(params[:email])
    user.send_password_reset if user
    redirect_to root_url, :notice => "Email sent with password reset instructions."
  end

  # function: edit(Password reset form)
  # params: tokenid
  # return: user
  def edit
    @user = User.find_by_password_reset_token!(params[:id])
  end

  # function: update(Password reset update)
  # params: token_id, password, password_confirmation
  def update
    @user = User.find_by_password_reset_token!(params[:id])
    if @user.password_reset_sent_at < 2.hours.ago
      redirect_to new_password_reset_path, :alert => "Password reset has expired."
    elsif params[:user][:password] != params[:user][:password_confirmation]
      redirect_to edit_password_reset_path, :notice => "Passwords are not match."
    elsif @user.update_attribute(:password, params[:user][:password])
      redirect_to root_url, :notice => "Password has been reset!"
    else
      render :edit
    end
  end
end
