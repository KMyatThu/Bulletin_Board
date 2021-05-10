class UsersController < ApplicationController
  before_action :authorized
  # function: User List
  # Return: userlist
  def index
    @users = UsersService.userList
  end

  # function: User Detai
  # params: id
  # return: user
  def show
    @user = UsersService.getUserById(params[:id])
  end

  # User New
  # return new user
  def new
    @user = User.new
  end

  # function: User Create Confirm
  # params: user form
  # return: user form
  def create_confirm
    @user = User.new(user_params)
    unless @user.valid?
      render new_user_path
    end
    # save profile image
    if user_params.has_key?(:profile)
      dir = "#{Rails.root}/app/assets/profiles/"
      FileUtils.mkdir_p(dir) unless File.directory?(dir)
      profilename = user_params[:name]+ "_" + Time.now.strftime('%Y%m%d_%H%M%S') + "." + ActiveStorage::Filename.new(user_params[:profile].original_filename).extension
      File.open(Rails.root.join('app/assets/', 'images', profilename ), 'wb') do |f|
          f.write(user_params[:profile].read)
      end
      @user.profile = profilename
    end
  end

  # function: Create User
  # params: user form
  def create
    isRegistUser = UsersService.createUser(user_params,current_user)
    if isRegistUser
      redirect_to users_path
    else
      render :new
    end
  end

  # function: Delete user
  # params: id
  def destroy
    UsersService.deleteUser(params[:id],current_user[:id])
    redirect_to users_path
  end

  # function: User Profile
  # params: id
  # return: user
  def profile
    @user = UsersService.getUserById(params[:id])
  end

  # function: editProfile
  # params: id
  # return: user
  def edit_profile
    user = UsersService.getUserById(params[:id])
    @user_profile_form = UserProfileForm.new(UserProfileForm.attributes(user, :new_profile))
  end

  # function: update profile
  # params: user profile params
  def update_profile
    @user_profile_form = UserProfileForm.new(user_profile_params)
    if !@user_profile_form.valid?
      render :edit_profile
    elsif user_profile_params[:new_profile].present?
      dir = "#{Rails.root}/app/assets/profiles/"
      FileUtils.mkdir_p(dir) unless File.directory?(dir)
      profilename = user_profile_params[:name]+ "_" + Time.now.strftime('%Y%m%d_%H%M%S') + "." + ActiveStorage::Filename.new(user_profile_params[:new_profile].original_filename).extension
      File.open(Rails.root.join('app/assets/', 'images', profilename ), 'wb') do |f|
          f.write(user_profile_params[:new_profile].read)
      end
      @user_profile_form.profile = profilename
      to_update_profile(@user_profile_form,current_user)
    else
      to_update_profile(@user_profile_form,current_user)
    end
  end

  # function: to update profile
  # params: user, current_user
  def to_update_profile(user_profile_form,current_user)
    isUpdateProfile = UsersService.updateProfile(user_profile_form,current_user)
    if isUpdateProfile
      redirect_to users_path
    else
      render :edit_profile
    end
  end

  # function: password change form
  # params: id
  def change_password
    @password_change_form = UserChangePasswordForm.new
  end

  # function: update change password
  # params: password params
  def update_password
    @password_change_form = UserChangePasswordForm.new(change_password_params)
    if !@password_change_form.valid?
      render :change_password
    else
    isPasswordUpdate = UsersService.updatePassword(change_password_params)
      if isPasswordUpdate
        redirect_to users_path
      else
        redirect_to change_password_user_path, notice: "Change Password is something wrong"
      end
    end
  end

  # function: User Search
  # params: search param
  # return: users
  def search_user
    @users = UsersService.searchuser(params)
    render :index
  end

  private
  # User params
  def user_params
    params.require(:user).permit(:id, :name, :email, :password, :password_confirmation, :role, :phone, :dob, :address, :profile, :create_user_id, :updated_user_id)
  end

  # User Profile Params
  def user_profile_params
    params.require(:user_profile_form).permit(:id, :name, :email, :role, :phone, :dob, :address, :profile, :new_profile)
  end

  # User Change Password Params
  def change_password_params
    params.require(:user_change_password_form).permit(:id, :current_password, :new_password, :new_password_confirmation)
  end
end