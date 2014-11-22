class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :user_signed_in?, :user_signed_out?, :admin?, :title

  def current_user
    if @current_user.blank?
      @current_user ||= (
        User.find_by(id: session[:user_id]) ||
        User.find_by(id: cookie.signed[:user_id])
      )

      set_user_cookies(@current_user)
    end

    @current_user
  end

  def current_user=(user)
    @current_user = user

    set_user_cookies(user)

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

  def title
    @title || "UNIFESP Shared"
  end

  def require_user
    redirect_to login_path unless user_signed_in?
  end

  private
  def set_user_cookies(user)
    if user.present?
      cookies.signed[:user_id] = { value: user.id, expires: 7.days }
      session[:user_id] = user.id
    else
      session.delete(:user_id)
      cookies.delete(:user_id)
    end
  end

end
