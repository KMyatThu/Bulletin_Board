class UserProfileForm
  include ActiveModel::Model
  include ActiveModel::Serialization

  attr_accessor :id, :name, :email, :role, :phone, :dob, :address, :profile
  validates :id, :name, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  def self.attributes(params)
    {
      :id => params.id,
      :name => params.name,
      :email => params.email,
      :role => nil,
      :phone => nil,
      :dob => nil,
      :address => nil,
      :profile => nil
    }
  end
end