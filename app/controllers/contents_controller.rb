class ContentsController < ApplicationController
  before_action :require_user
  before_action :set_pagination, only: :search
  before_action :reset_pagination, only: :browse

  def home
    @user = current_user
  end

  def browse
    @query = params[:query]
    @contents = search_contents
  end

  def search
    contents = search_contents
    rendered_data = render_to_string partial: "shared/feed",
      collection: contents
  
    render json: {
      next_page: contents.last_page? ? nil : contents.current_page + 1,
      result: rendered_data.strip
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

  def upvote
    render json: {
      value: Content.find(params[:id]).upvote_by(current_user)
    }
  end

  def downvote
    render json: {
      value: Content.find(params[:id]).downvote_by(current_user)
    }
  end

  # UNUSED
  def novote
    render json: {
      value: Content.find(params[:id]).novote_by(current_user)
    }
  end

  def upvote_comment
    render json: {
      value: Comment.find(params[:id]).upvote_by(current_user)
    }
  end

  def downvote_comment
    render json: {
      value: Comment.find(params[:id]).downvote_by(current_user)
    }
  end

  # UNUSED
  def novote_comment
    render json: {
      value: Comment.find(params[:id]).novote_by(current_user)
    }
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
    @comment = Comment.find(params[:comment_id])
    if current_user.id != @comment.user.try(:id)
      render :show, status: :unauthorized
    else
      @comment.destroy
    end
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
    if params[:search].present?
      if params[:tags].present?
        by_tags = Content.by_tags(*params[:tags].split(',')).pluck("DISTINCT contents.id")
        Content.where(id: by_tags)
          .search(params[:search], rank_by: (params[:rank_by] || :best).to_sym)
      else
        Content.search(params[:search], rank_by: (params[:rank_by] || :best).to_sym)
      end
    else
      start = if params[:tags].present?
        Content.where(id: Content.by_tags(*params[:tags].split(',')).pluck("DISTINCT contents.id"))
      else
        Content.all
      end
      start.where(user: current_user).order(created_at: :desc)
    end.page(@current_page).per(@per_page)
  end

end
