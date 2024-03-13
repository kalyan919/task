# spec/controllers/users_controller_spec.rb
require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'POST #create' do
    context 'with valid parameters' do
      let(:valid_params) { { username: 'test_user', email: 'test@example.com', password: 'password' } }

      it 'creates a new user' do
        post :create, params: valid_params
        expect(response).to have_http_status(:created)
        expect(User.count).to eq(1)
      end

      it 'returns a success message' do
        post :create, params: valid_params
        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)).to include('message' => 'User registered successfully')
      end
    end
  end

  describe 'POST #login' do
    let!(:user) { User.create(username: 'test_user', email: 'test@example.com', password: 'password') }

    context 'with valid credentials' do
      let(:valid_credentials) { { email: 'test@example.com', password: 'password' } }

      it 'returns a success message' do
        post :login, params: valid_credentials
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)).to include('message' => 'Login successful')
      end
    end

    context 'with invalid credentials' do
      let(:invalid_credentials) { { email: 'test@example.com', password: 'wrong_password' } }

      it 'returns an unauthorized status' do
        post :login, params: invalid_credentials
        expect(response).to have_http_status(:unauthorized)
        expect(JSON.parse(response.body)).to include('error' => 'Invalid email or password')
      end
    end
  end
end
