module Api
    module V1
      class UserController < ApplicationController
        skip_before_action :authenticate_request, only: [:login, :signup]

        def login
          result = UserService.login(user_params[:email], user_params[:password])
          render json: result.except(:status), status: result[:status]
        end

        def signup
          result = UserService.signup(user_params[:name], user_params[:email], user_params[:password], user_params[:role])
          render json: result.except(:status), status: result[:status]
        end

        private

        def user_params
          params.require(:user).permit(:name, :email, :password, :role)
        end
      end
    end
  end