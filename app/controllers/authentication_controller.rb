class AuthenticationController < ApplicationController
  def login
    @user = User.find_by(email: params[:email])

    if @user&.authenticate(params[:password])
      token = JWT.encode(payload, ENV['JWT_SECRET_KEY'], 'HS256')
      render json: { token: token }, status: :ok
    else
      render json: { error: 'Invalid credentials' }, status: :unauthorized
    end
  end
end
