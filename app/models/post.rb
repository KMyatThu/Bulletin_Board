class Post < ApplicationRecord
  belongs_to :created_user, class_name: "User", foreign_key: "create_user_id"
  belongs_to :updated_user, class_name: "User", foreign_key: "updated_user_id"

  validates :title, presence: true
  validates :description, presence: true

  def self.to_csv
    CSV.generate do |csv|
      csv << column_names
      all.each do |post|
        csv << post.attributes.values_at(*column_names)
      end
    end
  end

  def self.import(file,current_user_id)
    CSV.foreach(file.path, headers: true) do |row|
      post = Post.new
      post.title = row[0]
      post.description = row[1]
      post.status = row[2]
      post.create_user_id = current_user_id
      post.updated_user_id = current_user_id
      post.created_at = Time.now
      post.updated_at = Time.now
      post.save!
    end
  end
end
