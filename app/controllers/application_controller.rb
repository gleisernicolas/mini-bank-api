class ApplicationController < ActionController::API
  include Response
  include ExceptionHandler
  
  private
  def authenticate_user!
    @current_user = User.find_by_token(request.headers["Authorization"])

    if @current_user.nil?
      json_response({error: "Invalid token"}, :unauthorized)
    end
  end

  def authenticate_application!
    decoded_token = Base64.decode64(request.headers["Authorization"])

    app_name, token = decoded_token.split(':')
    if configuration(app_name).fetch('token') != token
      json_response({ error: "Invalid token or application"} , :unauthorized)
    end
  end

  def configuration(app_name)
    applications_tokens_path = Rails.root.join('config', 'applications.yml')

    YAML.load_file(applications_tokens_path)[Rails.env][app_name]
  end
end
