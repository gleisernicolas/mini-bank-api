Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace 'api' do
  	namespace 'v1' do
      resources :accounts, only: [:index, :show, :create]
      get 'accounts/by_referral_code/:referral_code', to: 'accounts#by_referral_code'
  	end
  end
end
