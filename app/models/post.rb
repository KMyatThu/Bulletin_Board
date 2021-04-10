require 'csv'
class Post < ApplicationRecord
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
end
