module Api
  module V1
    class UsersController < ApplicationController
      before_action :authenticate_application!

      def create
        user = User.new(user_params)

        if user.save
          json_response(user, :created)
        else
          json_response({ message: user.errors.messages }, :bad_request)
        end
      end

      private

      def user_params
        params.require(:user).permit(:name, :token)
      end
    end
  end
end