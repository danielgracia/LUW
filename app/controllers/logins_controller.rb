class LoginsController < ApplicationController
  def index
    @user = User.new(invite_token: params[:token])
  end

  def register
    @user = User.create(user_params)
    if @user.errors.blank?
      self.current_user = @user
      redirect_to root_path, notice: "Seu cadastro foi realizado com sucesso! Aproveite o UNIFESP Shared!"
    else
      render :index, status: :unprocessable_entity, alert: "Erros durante seu cadastro!"
    end
  end

  def login
    user = User.find_by(email: login_params[:email]).try(:authenticate, login_params[:password])
    if user.present?
      self.current_user = user
      redirect_to root_path
    else
      render :index, status: :unauthorized, alert: '¯\_(ツ)_/¯'
    end
  end

  def logout
    self.current_user = nil
    redirect_to :login_path, notice: "Você foi deslogado!"
  end

  protected
  def login_params
    params.permit(:email, :password)
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :invite_token)
  end

end
