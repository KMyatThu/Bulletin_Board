class UserChangePasswordForm
  include ActiveModel::Model
  include ActiveModel::Serialization
  
  attr_accessor :id, :current_password, :new_password, :new_confirm_password
  validates_presence_of :current_password, :new_password, :new_password_confirmation
  validates_confirmation_of :new_password
  validate :verify_old_password

  def verify_old_password
      user = UsersService.getUserById(id)
      self.errors[:current_password] << "is Not valid" if !user.authenticate(current_password)
  end
end