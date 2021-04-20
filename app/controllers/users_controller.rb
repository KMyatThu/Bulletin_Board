class UsersController < ApplicationController
  # User List
  # Return userlist
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
    user = User.new(user_params)
    unless user.valid?
      render new_user_path, errors: @user.errors.full_messages
    end
    # save profile image
    dir = "#{Rails.root}/app/assets/profiles/"
    FileUtils.mkdir_p(dir) unless File.directory?(dir)
    profilename = user_params[:name]+ "_" + Time.now.strftime('%Y%m%d_%H%M%S') + "." + ActiveStorage::Filename.new(user_params[:profile].original_filename).extension
    File.open(Rails.root.join('app/assets/', 'images', profilename ), 'wb') do |f|
        f.write(user_params[:profile].read)
    end
    user.profile = profilename
    @user = user
  end

  # function: Create User
  # params: user form
  def create
    isRegistUser = UsersService.createUser(user_params)
    if isRegistUser
      redirect_to users_path
    else
      render :new
    end
  end

  # function: Delete user
  # params: id
  def destroy
    UsersService.deleteUser(params[:id])
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
    @user = UsersService.getUserById(params[:id])
  end

  # function: update profile
  # params: user profile params
  def update_profile
    user = User.new(user_params)
    unless user_params[:profile].nil?
      dir = "#{Rails.root}/app/assets/profiles/"
      FileUtils.mkdir_p(dir) unless File.directory?(dir)
      profilename = user_params[:name]+ "_" + Time.now.strftime('%Y%m%d_%H%M%S') + "." + ActiveStorage::Filename.new(user_params[:profile].original_filename).extension
      File.open(Rails.root.join('app/assets/', 'images', profilename ), 'wb') do |f|
          f.write(user_params[:profile].read)
      end
      user.profile = profilename
    end
    user.role = user.role == "Admin" ? 0 : 1
    isUpdateProfile = UsersService.updateProfile(user)
    if isUpdateProfile
      redirect_to users_path
    else
      render :edit_profile
    end
  end

  # function: password change form
  # params: id
  def change_password

  end

  # function: update change password
  def update_password
    isUpdatePassword = UsersService.updatePassword(params)
    if isUpdatePassword
      redirect_to users_path
    else
      render :change_password
    end
  end

  private
  # User params
  def user_params
    params.require(:user).permit(:id, :name, :email, :password, :password_confirmation, :role, :phone, :dob, :address, :profile)
  end
end