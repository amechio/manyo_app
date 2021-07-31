class Label < ApplicationRecord
  has_many :links, dependent: :destroy
  has_many :tasks, through: :links

  validates :name, presence: true
end
