module Api
  module V1
    class AccountsController < ApplicationController
      before_action :authenticate!
      before_action :set_account, only: :show


      def index
        accounts = Account.order(:created_at)

        json_response(accounts)
      end

      def show
        json_response(@account)
      end

      def create
        account = Account.find_or_initialize_by(cpf: account_params['cpf']) 
        account.update(account_params)
        
        account.user = @current_user

        account.complete_account

        if account.save
          response_params = { message: 'Account created successfully!',
                             registration_status: account.status }
          response_params[:my_referral_code] = account.my_referral_code if account.status == 'completed'
          
          json_response(response_params, :created)
        else
          json_response({ message: account.errors.messages }, :bad_request )
        end
      end

      def by_referral_code
        primary_account = Account.find_by_my_referral_code(params[:referral_code])

        if primary_account.nil?
          json_response({ message: 'Referral code not found or not linked with a account' }, :not_found)
        elsif primary_account.status != 'completed'
          json_response({ message: 'Only completed accounts can have referrals'}, :not_acceptable)
        else
          accounts = Account.where(referral_code: params[:referral_code])
          json_response(format_referral_accounts(accounts))
        end
      end

      private
      
      def account_params
        params.require(:account).permit(:name,
                                        :email,
                                        :cpf,
                                        :birth_date,
                                        :gender,
                                        :city,
                                        :state,
                                        :country,
                                        :referral_code)
      end

      def set_account
        @account = Account.find(params['id'])
      end

      def format_referral_accounts(accounts)
        accounts.map { |account| {id: account.id, name: account.name } }
      end
    end
  end
end