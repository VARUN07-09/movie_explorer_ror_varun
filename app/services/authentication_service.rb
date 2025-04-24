class AuthenticationService
    def initialize(headers)
      @headers = headers
    end

    def authenticate
      token = extract_token
      return { error: 'Missing token', status: :unauthorized } unless token

      decoded = JwtService.decode(token)
      return { error: 'Invalid token', status: :unauthorized } unless decoded

      user = User.find_by(id: decoded['user_id'])
      return { error: 'User not found', status: :unauthorized } unless user

      { user: user }
    end

    private

    def extract_token
      header = @headers['Authorization']
      header.split(' ').last if header
    end
  end