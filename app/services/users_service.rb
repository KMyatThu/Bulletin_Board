class UsersService
  # user list
  def self.userList
    @users = UsersRepository.getAllUsers
  end

  # function: get user detail
  # params: id
  # return: user
  def self.getUserById(id)
    @user = UsersRepository.getUserById(id)
  end

  # function: create user
  # params: user form
  # return: isSaveUser
  def self.createUser(user)
    user = User.new(user)
    user.role = user.role == "Admin" ? 0 : 1
    user.create_user_id = 1
    user.updated_user_id = 1
    user.updated_at = Time.now
    isSaveUser = UsersRepository.createUser(user)
  end

  # function: delete user
  # params: id
  def self.deleteUser(id)
    user = getUserById(id)
    UsersRepository.deleteUser(user)
  end

  # function: update profile
  # params: user profile
  # return: isUpdateProfile(boolean)
  def self.updateProfile(user_params)
    UsersRepository.updateProfile(user_params)
  end

  # function: update password
  # params: password params
  # return: isPasswordUpdate(boolean)
  def self.updatePassword(params)
    user = getUserById(params[:id])
    if user.authenticate(params[:password]) && params[:new_password] == params[:new_password_confirmation]
      isPasswordUpdate = UsersRepository.updatePassword(user,params[:new_password])
    end
  end

  # function: Search user
  # params: search params
  # return: users
  def self.searchuser(keyword)
    name = keyword[:name]
    email = keyword[:email]
    from_date = keyword[:from_date]
    to_date = keyword[:to_date]
    users = UsersRepository.searchuser(name, email, from_date, to_date)
  end
end