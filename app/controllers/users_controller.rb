class UsersController < ApplicationController
  # User List
  # Return userlist
  def index
    @users = UsersService.userList
  end

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

  private
  # User params
  def user_params
    params.require(:user).permit(:id, :name, :email, :password, :password_confirmation, :role, :phone, :dob, :address, :profile)
  end
end