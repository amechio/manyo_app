class Task < ApplicationRecord
  validates :title, {presence: true}
  validates :content, {presence: true}
  validates :content, {length: {maximum:250} }
end
