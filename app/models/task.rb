class Task < ApplicationRecord
  validates :title, {presence: true}
  validates :content, {presence: true}
  validates :content, {length: {maximum:250} }

  def self.search(search)
    return Task.all unless search
    Task.where(['title LIKE ?', "%#{search}%"])
  end
  def self.search(search)
    return Task.all unless search
    Task.where(['status LIKE ?', "#{search}"])
  end

  enum status: {未着手:0, 着手中:1, 完了:2}
end
