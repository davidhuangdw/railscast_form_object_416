class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :password_digest, :token, :username, :subscribed_at
end
