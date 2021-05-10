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
  def self.createUser(user,current_user)
    user = User.new(user)
    user.role = user.role == "Admin" ? 0 : 1
    user.create_user_id = current_user.id
    user.updated_user_id = current_user.id
    user.updated_at = Time.now
    isSaveUser = UsersRepository.createUser(user)
  end

  # function: delete user
  # params: id
  def self.deleteUser(id,deleted_user_id)
    user = getUserById(id)
    UsersRepository.deleteUser(user,deleted_user_id)
  end

  # function: update profile
  # params: user_params, current_user
  # return: isUpdateProfile(boolean)
  def self.updateProfile(user_profile_form, current_user)
    user = getUserById(user_profile_form.id)
    user.updated_user_id = current_user.id
    # user_params.profile = user.profile unless user_params.profile.present?
    isUpdateProfile = UsersRepository.updateProfile(user,user_profile_form)
  end

  # function: update password
  # params: password params
  # return: isPasswordUpdate(boolean)
  def self.updatePassword(params)
    user = getUserById(params[:id])
    if user.authenticate(params[:current_password]) && params[:new_password] == params[:new_password_confirmation]
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