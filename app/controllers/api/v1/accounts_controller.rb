module Api
  module V1
    class AccountsController < ApplicationController
      def index
        accounts = Account.order(:created_at)
        render json: {data: accounts}, status: :ok
      end
    end
  end
end