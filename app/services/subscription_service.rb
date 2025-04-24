class SubscriptionService 
    def self.purchase_subscription(plan_id, current_user)
        return{errors: ['Admins cannot purchase subscription'], status: :forbidden} if current_user.role == 'admin'
        plan = SubscriptionPlan.find_by(id: plan_id)
        return { errors: ['Subscription plan not found'], status: :not_found} unless plan 
        if current_user.active_subscription
            return {errors: ['User already has an active subscription'], status: :unprocessable_entity}
        end
        subscription = current_user.subscriptions.build(subscription_plan: plan,  expires_at: Time.current +plan.duration.days)
        if subscription.save 
            {subscription: {id: subscription.id, plan: plan.name, expires_at: subscription.expires_at}, status: :created}
        else
            {errors: subscription.errors.full_messages, status: :unprocessable_entity}
        end
    end
    def self.can_access_movie?(current_user)
        return true if current_user.role =='admin'
        current_user.active_subscription.present?
    end
end