class TagsController < ApplicationController
  before_action :require_user

  def suggest
    render json: Tag.autocomplete(params[:query]).limit(5).pluck(:body)
  end
end