class ApplicationController < ActionController::API
 
 def authenticate_token
    begin
      payload = JWT.decode(request.headers['Authorization'], ENV['JWT_SECRET_KEY'], true, { algorithm: 'HS256' }).first
      @current_user = User.find(payload['user_id'])
    rescue JWT::DecodeError
      render json: { error: 'Invalid or missing token' }, status: :unauthorized
    end
  end



end
