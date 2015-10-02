class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  before_action :set_locale

  include Pundit

  after_action :verify_authorized, except: [:index, :show], unless: :devise_controller?
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(root_path)
  end
  def after_sign_out_path_for(resource_or_scope)
    root_path
  end

  def set_locale

    if extract_locale_from_tld && params[:locale] == 'en'
      I18n.locale = :en
    elsif I18n.locale == :fr && params[:locale] == nil
      I18n.locale = :fr
    elsif extract_locale_from_tld
      I18n.locale = extract_locale_from_tld
    else
      I18n.locale = params[:locale] || I18n.default_locale
    end
  end

  def extract_locale_from_tld
    parsed_locale = request.host.split('.').last
    I18n.available_locales.map(&:to_s).include?(parsed_locale) ? parsed_locale : nil
  end

  def default_url_options
    { locale: I18n.locale == I18n.default_locale ? nil : I18n.locale }
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit( :email, :password, :password_confirmation, :first_name, :last_name, :picture ) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:email, :password, :password_confirmation, :current_password, :first_name, :last_name, :picture) }
  end
end
