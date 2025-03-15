class AuthenticationController < ApplicationController
  skip_before_action :authenticate_request, only: [:login]

  def login
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      token = JWT.encode({ user_id: user.id }, Rails.application.credentials.secrets.secret_key_base)
      render json: { token: token }, status: :ok
    else
      render json: { error: 'Invalid credentials' }, status: :unauthorized
    end
  end
end
