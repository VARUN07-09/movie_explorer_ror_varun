class User < ApplicationRecord
    has_secure_password
    validates :name, presence: true, length: { maximum: 50 }
    validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :password, presence: true, length: { minimum: 6 }, on: :create
    validates :role, presence: true, inclusion: { in: %w[user admin] }

    has_many :subscriptions, dependent: :destroy
  end