class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  include Pundit::Authorization
  before_action :set_cookie_moon
  # Pundit: white-list approach
  after_action :verify_authorized, except: :index, unless: :skip_pundit?
  after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(root_path)
  end

  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[username photo])

    # For additional in app/views/devise/registrations/edit.html.erb
    devise_parameter_sanitizer.permit(:account_update, keys: %i[photo])
  end

  def moon
    @authorize
    cookies[:moon] = {
      value: 'on'
    }
    redirect_back fallback_location: root_path
  end

  def sun
    cookies[:moon] = {
      value: 'off'
    }
    redirect_back fallback_location: root_path
  end

  def set_cookie_moon
    cookies[:moon] = { value: 'on' } unless cookies[:moon]
    if cookies[:moon] == { value: 'off' }
      cookies[:moon] = { value: 'off' }
    elsif cookies[:moon] == { value: 'on' }
      cookies[:moon] = { value: 'on' }
    end
  end

  private

  def skip_pundit?
    devise_controller? ||
      params[:controller] =~ /(^(rails_)?admin)|(^pages$)/ ||
      action_name == "moon" ||
      action_name == "sun"
  end
end
