require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  before do
    request.headers['Authorization'] = Base64.encode64('ios_app:random_token_trust_me')
    request.headers['Content-Type'] = 'application/json'
  end

  describe 'POST /api/v1/users' do
    context 'with valid attributes' do
      it 'create a user' do
        expect {
          post :create,
                params: {
                  name: Faker::Name.name,
                  token: SecureRandom.alphanumeric(8)
          }
        }.to change(User, :count).by(1)

        expect(response).to have_http_status(:created)
      end
    end

    context 'with invvalid attributes' do
      it 'does not create a user' do
        expect {
          post :create,
                params: {
                  name: nil,
                  token: SecureRandom.alphanumeric(8)
          }
        }.not_to change(User, :count)

        expect(response).to have_http_status(:bad_request)
      end
    end
  end
end