class UserProfileForm
  include ActiveModel::Model
  include ActiveModel::Serialization

  attr_accessor :id, :name, :email, :role, :phone, :dob, :address, :profile, :new_profile
  validates :id, :name, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  # def initialize(params)
  #   @user = User.new
  #   super(params)
  #   @new_profile = nil
  # end

  def self.attributes(params, new_profile)
    {
      :id => params.id,
      :name => params.name,
      :email => params.email,
      :role => params.role,
      :phone => params.phone,
      :dob => params.dob,
      :address => params.address,
      :profile => params.profile,
      :new_profile => new_profile
    }
  end
end