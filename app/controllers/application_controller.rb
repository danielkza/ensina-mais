class ApplicationController < ActionController::Base
  protected

  def authenticate
    @current_user ||= authenticate_with_http_token do |token, options|
      User.find_by(auth_token: token)
    end

    !@current_user.nil?
  end

  def authenticate!
    unless authenticate
      render json: {error: "Unauthorized"}, status: :unauthorized
      return false
    end

    true
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def ensure_json
    return if params[:format] == "json"
    return if Mime::Type.parse(request.headers["Accept"]).include?('json')
    return if (request.headers['Content-Type'] || '').include?('json')

    render nothing: true, status: :not_acceptable
  end

  def check_user(user, &block)
    if current_user
      if block_given?
        return if block.call(user)
      else
        return if current_user.id == user.id
      end
    end

    not_authorized
  end

  def not_authorized(message="Not Authorized")
    render json: {error: message}, status: :unauthorized
  end
end
