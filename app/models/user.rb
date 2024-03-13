class User < ApplicationRecord
  validates :username, presence: true, uniqueness: true
  validates :password_digest, presence: true
  has_many :blogs

  def password=(new_password)
    self.password_digest = hash_password(new_password)
  end

  def authenticate(password)
    hash_password(password) == password_digest
  end

  private

  def hash_password(password)
    Digest::SHA256.hexdigest(password)
  end
end
