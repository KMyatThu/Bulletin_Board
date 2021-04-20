class UsersRepository
  # function: get all Users
  # return: users
  def self.getAllUsers
    @users = User.all
  end

  # function: get user by id
  # params: id
  # return: user
  def self.getUserById(id)
    @user = User.find(id)
  end

  # function: create user
  # params: create
  # return: isSaveUser(boolean)
  def self.createUser(user)
    isSaveUser = user.save
  end

  # function: delete user
  # params: user
  def self.deleteUser(user)
    user.destroy
  end

  # function: update profile
  # params: user
  # return: isUpdateProfile(boolean)
  def self.updateProfile(user_params)
    user = User.find(user_params[:id])
    isUpdateProfile = user.update(
      'name' => user_params[:name],
      'email' => user_params[:email],
      'role' => user_params[:role],
      'phone' => user_params[:phone],
      'dob' => user_params[:dob],
      'address' => user_params[:address],
      'profile' => user_params[:profile]
    )
  end

  # function: update password
  # params: user,password
  # return: isUpdatePassword
  def self.updatePassword(user,password)
    isUpdatePassword = user.update(
      'password' => password
    )
  end
end