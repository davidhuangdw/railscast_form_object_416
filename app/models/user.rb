class User < ActiveRecord::Base
  has_secure_password
  has_one :profile, dependent: :destroy
  validates :password, :username, :email, presence: true
  validates :email, uniqueness: true, format:{with:/\A[^@\s]+@([-\w]+\.)+[a-z]{2,}\Z/}
  validates :password, length:{minimum: 6}, on: :create

  before_create :generate_token

  def refresh_token!
    generate_token
    save!(validate:false)
  end
  def generate_token
    begin
      self.token = SecureRandom.hex
    end while User.exists?(token:token)
  end
end
