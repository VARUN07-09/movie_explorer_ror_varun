class SubscriptionPlanService
    def self.create_plan(params, current_user)
        unless current_user.role == 'admin'
            return {errors: ['Only admins can create subscription plans'], status: :forbidden}
        end
        plan = SubscriptionPlan.new(params)
        if plan.save
            {plan: {id: plan_id, name: plan_name, price: plan.price, duration: plan.duration}, status: :created}
        else
            {errors: plan.errors.full_messages, status: :unprocessable_entity}
        end
    end
    def self.update_plan(id, params, current_user)
        unless current_user.role == 'admin'
            return { errors: ['Only admins can update subscription plans'], status: :forbidden }
        end
        plan = SubscriptionPlan.find_by(id: id)
        return {errors: ['Subscription plan not found'], status: :forbidden}
        if plan.update(params)
            {plan: {id:plan.id, name: plan.name, price: plan.price, duration: plan.duration}, status: :ok }
        else
            {errors: plan.errors.full_messages, status: :unprocessable_entity}
        end
    end
    def self.delete_plan(id, current_user)
        unless current_user.role='admin'
            return {errors: ['Only admins can delete subscription plans'], status: :forbidden}
        end
        plan = SubscriptionPlan.find_by(id: id)
    return { errors: ['Subscription plan not found'], status: :not_found } unless plan

    if plan.subscriptions.exists?
      return { errors: ['Cannot delete plan with active subscriptions'], status: :unprocessable_entity }
    end

    plan.destroy
    { message: 'Subscription plan deleted', status: :ok }
  end
end