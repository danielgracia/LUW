class ContentsController < ApplicationController
  before_action :require_user
  before_action :set_pagination, only: :search
  before_action :reset_pagination, only: :browse

  def home
    @user = current_user
  end

  SEARCH_RANKING = [:best, :best, :worst, :newest, :oldest]

  def browse
    @query = params[:query]
    @contents = search_contents
  end

  def search
    contents = Content.by_tags(*params[:tags].split(','))
      .search(params[:search], rank_by: SEARCH_RANKING[params[:rank_by]])
      .paginate(params[:per_page])
  
    render json: {
      next_page: contents.last_page? ? nil : contents.current_page + 1
      result: contents
    }
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

  def set_pagination
    @current_page = params[:page] || 1
    @per_page = params[:per_page] || 10
  end

  def reset_pagination
    @current_page = 1
    @per_page = 10
  end

  def search_contents
    Content.by_tags(*params[:tags].split(','))
      .search(params[:search], rank_by: SEARCH_RANKING[params[:rank_by]])
      .page(@current_page).per(@per_page)
  end

end
