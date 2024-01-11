class UsersController < ApplicationController
 def create
    user = User.new(user_params)
    if user.save
      token = JWT.encode({ user_id: user.id }, ENV['JWT_SECRET_KEY'], 'HS256')
      render json: { token: token }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end






end
