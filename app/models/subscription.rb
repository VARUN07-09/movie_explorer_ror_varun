class Subscription < ApplicationRecord
    belongs_to :user
    belongs_to :subscription_plan
  
    validates :expires_at, presence: true
    validate :user_must_not_have_active_subscription, on: :create
  
    private
  
    def user_must_not_have_active_subscription
      if user.subscriptions.exists?(["expires_at > ?", Time.current])
        errors.add(:base, "User already has an active subscription")
      end
    end
end