class UserService
    def self.login(email, password)
        user= User.find_by(email: email)
        return {error: 'Invalid email or password', status: :unauthorized} unless user&.authenticate(password)

        token =JwtService.encode(user_id: user.id)
        {token: token, user: {id: user.id, name: user.name, email: user.email, role: user.role}, status: :ok}
    end
    def self.signup(name, email, password, role)
        user = User.new(name: name , email: email, password: password, role: role)
        return {errors: user.errors.full_messages, status: :unprocessable_entity}unless user.save 
    end
end