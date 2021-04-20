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
end