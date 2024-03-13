require_relative '../lib/json_web_token'

class BlogsController < ApplicationController
  before_action :authorize_user, only: [:index]

  def index
    blogs = @current_user.blogs
    render json: blogs
  end

  private

  def authorize_user
    token = request.headers['Authorization']&.split(' ')&.last
    decoded_token = JsonWebToken.decode(token)

    if decoded_token && (user_id = decoded_token['user_id'])
      @current_user = User.find(user_id)
    else
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end
end
