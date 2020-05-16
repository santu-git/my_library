class Author < ApplicationRecord
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :about_author,length: {minimum: 15}, allow_blank: false

  def self.total_count
    count
  end

  def short_name
    "#{first_name.first}. #{last_name}"
  end
end
