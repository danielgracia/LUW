class UsersController < ApplicationController

  def register
    @token = params[:token]
  end

  def create
  end

  def login
  end

  def show
  end

  def you
    @user = current_user
  end

end
