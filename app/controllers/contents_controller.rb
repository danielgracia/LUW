class ContentsController < ApplicationController
  before_action :require_user

  def home
    @user = current_user
  end

  def browse
  end

  def search
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

end
