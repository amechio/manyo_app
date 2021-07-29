class User < ApplicationRecord
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }

  has_many :tasks, dependent: :destroy

  before_update :admin_update
  before_destroy :admin_destroy

  private
  def admin_update
    throw(:abort) if self.admin == false && User.where(admin: true).count <= 1
  end
  def admin_destroy
    throw(:abort) if self.admin == true && User.where(admin: true).count <= 1
  end
end
