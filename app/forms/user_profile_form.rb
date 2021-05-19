class UserProfileForm
  include ActiveModel::Model

  attr_accessor :id, :name, :email, :role, :phone, :dob, :address, :profile, :new_profile
  validates :id, :name, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  # def initialize(params)
  #   @user_profile_form = User.new
  #   super(params)
  #   # @id = params[:id]
  #   # @name = params[:name]
  #   # @email = params[:email]
  #   # @role = params[:role]
  #   # @phone = params[:phone]
  #   # @dob = params[:dob]
  #   # @address = params[:address]
  #   # @profile = params[:profile]
  #   @new_profile = params[:new_profile]
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