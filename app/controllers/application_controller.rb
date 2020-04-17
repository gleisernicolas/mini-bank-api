class ApplicationController < ActionController::API
  include Response
  include ExceptionHandler
  
  before_action :authenticate!

  private
  def authenticate!
    @current_user = User.find_by_token(request.headers["Authorization"])

    if @current_user.nil?
      json_response({error: "Invalid token"}, :unauthorized)
    end
  end
end
