class SubscriptionPlan < ApplicationRecord
    validates :name, presence: true, uniqueness: true
    validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
    validates :duration, presence: true, numericality: { greater_than: 0 }
  
    has_many :subscriptions, dependent: :restrict_with_error
    
  end