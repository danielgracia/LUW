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
      redirect_to show_content_path(@content)
    else
      render :new, alert: "Erros encontrados!"
    end
  end

  def show
    @content = Content.find(params[:id])
    @comment = Comment.new
  end

  def edit
  end

  def update
    @content = current_user.contents.find_by(id: params[:id])
    if @content.blank?
      redirect_to :root, alert: "RÁQUIO!"
    elsif @content.errors.blank?
      redirect_to show_content_path(@content), notice: "Postagem atualizada com sucesso!"
    else
      redirect_to edit_content_path(@content), alert: "Erros encontrados!"
    end
  end

  def comment
    @content = Content.find(params[:content_id])
    @comment = @content.comments.create(comment_params.merge(user_id: current_user.id))
    if @comment.blank?
      redirect_to show_content_path(@content), alert: "Erros encontrados!"
    else
      redirect_to show_content_path(@content), notice: "Comentário postado!"
    end
  end

  def delete_comment
    @content = Content.find(params[:content_id])
    @comment = Content.find(params[:comment_id])
    @comment.destroy
    render :show, notice: "Comentário deletado!"
  end

  protected
  def content_params
    params.require(:content).permit(:title, :body, :raw_tags)
  end

  def comment_params
    params.require(:comment).permit(:body)
  end

end
