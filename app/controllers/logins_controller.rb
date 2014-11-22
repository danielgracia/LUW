class UsersController < ApplicationController

  def index
  end

  def register
    @token = params[:token]
  end

  def login
  end

  def logout
  end


end
