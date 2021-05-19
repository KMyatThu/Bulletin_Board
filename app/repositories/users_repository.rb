class UsersRepository
  # function: get all Users
  # return: users
  def self.getAllUsers
    @users = User.where(deleted_user_id: nil)
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
  def self.deleteUser(user,deleted_user_id)
    user.update_attribute(:deleted_at, Time.now)
    user.update_attribute(:deleted_user_id, deleted_user_id)
  end

  # function: update profile
  # params: user
  # return: isUpdateProfile(boolean)
  def self.updateProfile(user,user_params)
    isUpdateProfile = user.update(
      'name' => user_params.name,
      'email' => user_params.email,
      'role' => user_params.role,
      'phone' => user_params.phone,
      'dob' => user_params.dob,
      'address' => user_params.address,
      'profile' => user_params.profile
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

  # function: search user
  # params: search params
  # return: users
  def self.searchuser(name, email, from_date, to_date)
    if from_date.present? and to_date.present?
      users = User.where(deleted_user_id: nil).where("name like ? and email like ? and created_at >= ? and created_at <= ?", "%" + name + "%", "%" + email + "%", from_date, Date.parse(to_date)+1)
    elsif from_date.present?
      users = User.where(deleted_user_id: nil).where("name like ? and email like ? and created_at >= ?", "%" + name + "%", "%" + email + "%", from_date)
    elsif to_date.present?
      users = User.where(deleted_user_id: nil).where("name like ? and email like ? and created_at <= ?", "%" + name + "%", "%" + email + "%", Date.parse(to_date)+1)
    else
      users = User.where(deleted_user_id: nil).where("name like ? and email like ?", "%" + name + "%", "%" + email + "%")
    end
  end

  # function: Get User By Email
  # params: email
  # return: user
  def self.getUserByEmail(email)
    user = User.where(deleted_user_id: nil).find_by(email)
  end
end