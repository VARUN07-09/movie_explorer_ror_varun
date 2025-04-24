module Api
    module V1
        class SubscriptionController < ApplicationController
            before_action :authenticate_request
            def create
                result = SubscriptionService.purchase_subscription(params[:plan_id],current_user)
                render json: result.except(:status), status: result[:status]
            end
        end
    end
end