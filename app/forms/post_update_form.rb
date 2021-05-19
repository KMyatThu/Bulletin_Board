class PostUpdateForm
  include ActiveModel::Model

  attr_accessor :id, :title, :description, :status, :create_user_id, :updated_user_id
  validates_presence_of :title, :description, :status, presence: true

  def self.attributes(params)
    {
      :id => params.id,
      :title => params.title,
      :description => params.description,
      :status => params.status
    }
  end
end