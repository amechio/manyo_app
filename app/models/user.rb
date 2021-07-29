class User < ApplicationRecord
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }

  has_many :tasks, dependent: :destroy

  before_update :admin_check
  before_destroy :admin_check

  private
  def admin_check
      throw(:abort) if self.admin == true && User.where(admin: true).count <= 1
  end
end
