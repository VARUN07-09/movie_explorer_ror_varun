module Api
    module V1
      class SubscriptionPlansController < ApplicationController
        before_action :authenticate_request
  
        def create
          result = SubscriptionPlanService.create_plan(subscription_plan_params, current_user)
          render json: result.except(:status), status: result[:status]
        end
  
        def update
          result = SubscriptionPlanService.update_plan(params[:id], subscription_plan_params, current_user)
          render json: result.except(:status), status: result[:status]
        end
  
        def destroy
          result = SubscriptionPlanService.delete_plan(params[:id], current_user)
          render json: result.except(:status), status: result[:status]
        end
  
        private
  
        def subscription_plan_params
          params.require(:subscription_plan).permit(:name, :price, :duration)
        end
      end
    end
  end