class ApplicationController < ActionController::API
    before_action :authenticate_request
    def authenticate_request
      header = request.headers['Authorization']
      token = header.split(' ').last if header.present?
      
      begin
        decoded = JwtService.decode(token)
        @current_user = User.find(decoded[:user_id])
      rescue ActiveRecord::RecordNotFound, JWT::DecodeError
        render json: { error: 'Unauthorized' }, status: :unauthorized
      end
    end
  end
  