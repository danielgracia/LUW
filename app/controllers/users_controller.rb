class UsersController < ApplicationController
  before_action :require_user

  def home
    @user = current_user
  end

end
