class User < ApplicationRecord
  # has_secure_password - requires uncommenting '''gem "bcrypt", "~> 3.1.7"''' in Gemfile
  has_many :repos, dependent: :destroy
end
