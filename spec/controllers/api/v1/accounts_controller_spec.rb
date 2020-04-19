require 'rails_helper'

RSpec.describe Api::V1::AccountsController, type: :controller do
  let(:user) { create(:user) }

  before do
    request.headers['Authorization'] = user.token
    request.headers['Content-Type'] = 'application/json'
  end
  
  describe 'GET /api/v1/accounts/index' do
    it 'return all accounts' do
      expected_account = create_list(:account, 10)
      
      get :index

      parsed_body = JSON.parse(response.body)

      expect(response).to have_http_status(:ok)
      expect(parsed_body.size).to eq(10)
    end
  end

  describe 'GET /api/v1/accounts/:account_id' do
    context 'when the account exists' do
      let(:account) { create(:account) }

      it 'return the account' do
        get :show, params: { id: account.id }

        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['name']).to eq(account.name)
      end
    end

    context 'when the account doesnt exists' do
      it 'return error 404' do
        get :show, params: { id: 999 }

        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'POST /api/v1/accounts' do
    context 'with valid attributes' do
      it 'create a account' do
        name = Faker::Name.name
        
        expect {
          post :create,
                params: {
                  name: name,
                  email:  Faker::Internet.email,
                  cpf:  Faker::IDNumber.brazilian_citizen_number,
                  birth_date:  20.years.ago.to_date,
                  gender:  Faker::Gender.type,
                  city:  Faker::Address.city,
                  state:  Faker::Address.state,
                  country:  Faker::Address.country,
                  referral_code:  Faker::Number.number(digits: 8)
          }
        }.to change(Account, :count).by(1)

        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)['name']).to eq(name)
        expect(JSON.parse(response.body)['status']).to eq('completed')
        expect(JSON.parse(response.body)['my_referral_code']).not_to be_nil
      end
    end

    context 'with valid and incomplete params' do
      it 'create the account with pending status' do
        expect {
          post :create,
                params: {
                  name: Faker::Name.name,
                  cpf:  Faker::IDNumber.brazilian_citizen_number,
                  referral_code:  Faker::Number.number(digits: 8)
          }
        }.to change(Account, :count).by(1)

        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)['status']).to eq('pending')
        expect(JSON.parse(response.body)['my_referral_code']).to be_nil
      end

      it 'create the account with pending status and change to complete when the rest of the params is sent' do
        name = Faker::Name.name
        cpf = Faker::IDNumber.brazilian_citizen_number
        
        expect {
          post :create,
                params: {
                  name: name,
                  email:  Faker::Internet.email,
                  cpf:  cpf,
                  birth_date:  20.years.ago.to_date
          }
        }.to change(Account, :count).by(1)
        
        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)['status']).to eq('pending')
        expect(JSON.parse(response.body)['my_referral_code']).to be_nil
        expect(JSON.parse(response.body)['name']).to eq(name)

        id = JSON.parse(response.body)['id']

        expect {
          post :create,
                params: {
                  cpf:  cpf,
                  gender:  Faker::Gender.type,
                  city:  Faker::Address.city,
                  state:  Faker::Address.state,
                  country:  Faker::Address.country,
                  referral_code:  Faker::Number.number(digits: 8)
          }
        }.not_to change(Account, :count)

        expect(JSON.parse(response.body)['status']).to eq('completed')
        expect(JSON.parse(response.body)['my_referral_code']).not_to be_nil
        expect(JSON.parse(response.body)['name']).to eq(name)
        expect(JSON.parse(response.body)['id']).to eq(id)
      end
    end

    context 'with invalid attributes' do
      it 'return error and does not create the account' do
        expect {
          post :create,
                params: {
                 account: attributes_for(:account).except(:cpf)
          }
        }.not_to change(Account, :count)

        expect(response).to have_http_status(:bad_request)
      end
    end

    context 'when the account doesnt exists' do
      it 'return error 404' do
        get :show, params: { id: 999 }

        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'GET /api/v1/accounts/by_referral/:referral_code' do
    context 'when the account exists' do
      context 'and is a complete account' do
        let(:complete_account) { create(:account, status: 'completed') }
        let!(:referral_accounts) { create_list(:account, 2, referral_code: complete_account.my_referral_code) }
        let!(:unrelated_accounts) { create_list(:account, 5)}

        it 'return referrals for said account' do
          get :by_referral_code, params: { referral_code: complete_account.my_referral_code }

          expect(response).to have_http_status(:ok)
          expect(JSON.parse(response.body).size).to be(2)
        end
      end

      context 'and is not complete' do
        let(:incomplete_primary_account) { create(:account, status: 'pending')}
        let(:referral_account) { create(:account, referral_code: incomplete_primary_account.my_referral_code) }

        it 'return error with the message "Only completed accounts can have referrals"' do
          get :by_referral_code, params: { referral_code: incomplete_primary_account.my_referral_code}

          expect(response).to have_http_status(:not_acceptable)
          expect(JSON.parse(response.body)['message']).to eq('Only completed accounts can have referrals')
        end
      end
    end

    context 'when the account does not exist' do
      let!(:unrelated_accounts) { create_list(:account, 5)}

      it 'return error with the message "Referral code not found or not linked with a account"' do
        get :by_referral_code, params: { referral_code: '999xxx66'}

        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)['message']).to eq('Referral code not found or not linked with a account')
      end
    end
  end
end