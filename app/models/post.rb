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

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      post = Post.new
      post.title = row[1]
      post.description = row[2]
      post.status = row[3]
      post.create_user_id = row[4]
      post.updated_user_id = row[5]
      post.deleted_user_id = row[6]
      post.deleted_at = row[7]
      post.created_at = row[8]
      post.updated_at = row[9]
      post.save
    end
  end
end
