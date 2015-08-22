class AuthenticationController < ApplicationController
  before_action :ensure_json, :authenticate
  before_action :authenticate!, only: [:logout]
  before_action :set_login_info, only: [:login]

  class << self
    def fb_app_id
      Rails.application.secrets.facebook['app_id']
    end

    def fb_app_oauth
      @fb_app_oauth ||= Koala::Facebook::OAuth.new(
          fb_app_id,
          Rails.application.secrets.facebook['app_secret'])
    end

    def fb_app_token
      @fb_app_token ||= fb_app_oauth.get_app_access_token
    end

    def fb_app_graph
      @fb_app_graph ||= Koala::Facebook::API.new(fb_app_token)
    end

    def check_user_in_roles(user, *roles)
      role = fb_app_graph.get_connection(fb_app_id, 'roles').find { |role|
        role.user == user.facebook_id
      }
      role && roles.include?(role['role'])
    end
  end

  def verify_login_info(login_info)
    debug_info = self.class.fb_app_graph.debug_token(login_info.access_token)
    debug_info = debug_info['data']

    logger.debug "Facebook Debug Token result:"
    logger.debug debug_info

    return false unless debug_info['is_valid']
    return false if debug_info['app_id'].to_s != self.class.fb_app_id.to_s
    return false if debug_info['user_id'].to_s != login_info.user_id.to_s

    true
  end

  def login
    if current_user
      render json: {error: "Already logged in"}, status: :bad_request
    elsif !@login_info || !verify_login_info(@login_info)
      render json: {error: "Invalid login information or not authorized"},
             status: :unauthorized
    else
      user = User.find_by(facebook_id: @login_info.user_id)
      unless user
        info = self.class.fb_app_graph.get_object(@login_info.user_id, {
          fields: ['name']
        })
        name = info['name']
        user = User.new(facebook_id: @login_info.user_id, name: name)
      end

      user.facebook_token = @login_info.access_token
      user.save!

      session[:user_id] = user.id
      response.headers["Authorization"] =
          ActionController::HttpAuthentication::Token.encode_credentials(user.auth_token)

      @user = user
      render 'users/show', format: :json, location: @user
    end
  end

  def logout
    @current_user.update_attributes!(auth_token: nil)
    session.delete(:user_id)
    render nothing: true
  end

  protected

  def set_login_info
    @login_info = LoginInfo.new(authentication_params)
  end

  def authentication_params
    params.require(:authentication).permit(:application_id, :user_id, :access_token)
  end
end
