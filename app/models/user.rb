class User < ApplicationRecord
    has_many :events
    validates :name, :email, :password_digest, presence: true
    validates :email, uniqueness: true
end
