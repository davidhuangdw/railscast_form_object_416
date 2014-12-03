class User < ActiveRecord::Base
  has_secure_password
  has_one :profile, dependent: :destroy
  accepts_nested_attributes_for :profile

  validates :username, :email, presence: true
  validates :email, uniqueness: true, format:{with:/\A[^@\s]+@([-\w]+\.)+[a-z]{2,}\Z/}
  validates :password, presence:true, length:{minimum: 6},  on: :create

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

  attr_accessor :changing_password, :original_password, :new_password
  validate :verify_original_password, if: :changing_password
  validates :new_password, length:{minimum:6}, confirmation: true, if: :changing_password

  def verify_original_password
    unless authenticate(original_password)
      errors.add :original_password, 'is not correct.'
    end
  end
  def change_password
    @changing_password =false
    update!(password:new_password, password_confirmation:new_password)
  end
end
