class PasswordForm
  include ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations
  def persisted?; false end
  def initialize(user); @user=user end

  def submit(params)
    for k,v in params
      send("#{k}=", v)
    end
    valid?.tap do |v|
      @user.change_password(new_password) if v
    end
  end

  attr_accessor :changing_password, :original_password, :new_password
  validate :verify_original_password
  validates :new_password, length:{minimum:6}, confirmation: true

  def verify_original_password
    unless @user.authenticate(original_password)
      errors.add :original_password, 'is not correct.'
    end
  end
end