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
    @content = current_user.contents.create(content_params)
    if @content.errors.blank?
      render :show
    else
      render :new, alert: "Erros encontrados!"
    end
  end

  def show
    @content = Content.find(params[:id])
  end

  def edit
  end

  def update
    @content = current_user.contents.find_by(id: params[:id])
    if @content.blank?
      redirect_to :root, alert: "RÁQUIO!"
    elsif @content.errors.blank?
      render :show, notice: "Postagem atualizada com sucesso!"
    else
      render :edit, alert: "Erros encontrados!"
    end
  end

  protected
  def content_params
    params.require(:user).permit(:title, :body, :raw_tags)
  end

end
