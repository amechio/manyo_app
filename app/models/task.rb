class Task < ApplicationRecord
  validates :title, {presence: true}
  validates :content, {presence: true}
  validates :content, {length: {maximum:250} }

  enum status: {未着手:0, 着手中:1, 完了:2}
  enum priority: { 低:0, 中:1, 高:2}

  scope :title_search, -> (title) {
    where("title LIKE ?", "%#{ title }%")
  }
  scope :status_search, -> (status) {
    where(status: status)
  }
  scope :priority_search, -> (priority) {
    where(priority: priority)
  }

  belongs_to :user
  has_many :links, dependent: :destroy
  has_many :labels, through: :links
end
