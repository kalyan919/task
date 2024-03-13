require 'rails_helper'

RSpec.describe BlogsController, type: :controller do
  describe 'GET #index' do
    let(:user) { User.create(username:"testing", password:"testing", email: "testing@gmail.com") } 
    it 'returns a success response for authorized user' do
      token = JsonWebToken.encode(user_id: user.id)
      request.headers['Authorization'] = "Bearer #{token}"

      get :index

      expect(response).to have_http_status(:success)
    end

    it 'returns unauthorized for invalid token' do
      request.headers['Authorization'] = 'Bearer invalid_token'

      get :index

      expect(response).to have_http_status(:unauthorized)
    end

    it 'returns unauthorized for missing token' do
      get :index

      expect(response).to have_http_status(:unauthorized)
    end
  end
end