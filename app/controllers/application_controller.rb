class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :user_signed_in?, :user_signed_out?

  def current_user
    @current_user ||= (
      User.find_by(id: session[:user_id]) ||
      User.find_by(id: cookie.signed[:user_id])
    )

    if @current_user.present?
      cookies.signed[:user_id] = { value: @current_user.id, expires: 7.days }
      session[:user_id] = @current_user.id
    else
      session.delete(:user_id)
      cookies.delete(:user_id)
    end

    @current_user
  end

  def admin?
    current_user.try(:admin?)
  end

  def user_signed_in?
    current_user.present?
  end

  def user_signed_out?
    current_user.blank?
  end

  def require_user
    redirect_to login_path unless user_signed_in?
  end

end
