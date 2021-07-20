class Task < ApplicationRecord
  validates :title, {presence: true}
  validates :content, {presence: true}
  validates :content, {length: {maximum:250} }

  enum status: {未着手:0, 着手中:1, 完了:2}
#  def title_search(search)
    #return Task.all unless search
#    Task.where(['title LIKE ?', "%#{search}%"])
#  end

  scope :title_search, -> (title) {
    where("title LIKE ?", "%#{ title }%")
  }

  scope :status_search, -> (status) {
    where(status: status)
  }

  #def status_search(search)
    #return Task.all unless search
  #  Task.where(['status LIKE ?', "#{search}"])
  #end
end
