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
          json_response(account, :created)
        else
          json_response({message: account.errors.messages},:bad_request )
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
    end
  end
end