module Api
    module V1
      class UserController < ApplicationController
        skip_before_action :authenticate_request, only: [:login, :signup]
  
        def login
          user = User.find_by(email: params[:email])
          if user&.authenticate(params[:password])
            token = JwtService.encode(user_id: user.id)
            render json: { token: token, user: user }, status: :ok
          else
            render json: { error: 'Invalid email or password' }, status: :unauthorized
          end
        end
        
  
        def signup
          result = UserService.signup(user_params[:name], user_params[:email], user_params[:password])
          render json: result.except(:status), status: result[:status]
        end
  
        private
  
        def user_params
          params.require(:user).permit(:name, :email, :password)  
        end
      end
    end
  end
  