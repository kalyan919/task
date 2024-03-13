class UsersController < ApplicationController
  def create
    @user = User.new(user_params)

    if @user.save
      render json: { message: 'User registered successfully' }, status: :created
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def login
    user = User.find_by(email: params[:email])
    
    if user&.authenticate(params[:password])
      token = generate_token(user)
      render json: { message: 'Login successful', token: token }
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end


  private

  def user_params
    params.permit(:username, :email, :password)
  end

  def generate_token(user)
    payload = { user_id: user.id, exp: 1.day.from_now.to_i }
    JWT.encode(payload, Rails.application.secrets.secret_key_base)
  end
end
