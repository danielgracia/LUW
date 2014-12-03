class TagsController < ApplicationController
  before_action :require_user

  def suggest
    render json: Tag.all.pluck(:body)
  end
end