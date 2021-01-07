Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
      resources :accounts, only: [:show, :create]

      get 'accounts/by_referral_code/:referral_code', to: 'accounts#by_referral_code'

      resources :users, only: [:create]
  	end
  end
end
