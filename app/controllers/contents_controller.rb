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
    @content = Content.new
  end

  def create
  end

  def edit
  end

  def update
  end

  protected
  def content_params
    params.require(:user).permit(:title, :body, :raw_tags, :attachment_ul)
  end

end
