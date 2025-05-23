class ApplicationController < ActionController::API
    before_action :authenticate_request
  
    private
  
    def authenticate_request
        header = request.headers['Authorization']
        
        token = header.split(' ').last if header.present?
        
      
        begin
          decoded = JwtService.decode(token)
          
          @current_user = User.find(decoded['user_id'])
          Rails.logger.debug "Authenticated User: #{@current_user.inspect}"
        rescue => e
          Rails.logger.error "Auth Error: #{e.message}"
          render json: { error: 'Unauthorized' }, status: :unauthorized
        end
      end
      
  
    def current_user
      @current_user
    end
  end
  