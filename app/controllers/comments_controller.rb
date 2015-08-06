class CommentsController < ApplicationController

  before_filter :authenticate, except: [:index, :show]

  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.create(comment_params)
    respond_to do |format|
      format.html { redirect_to @article }
      format.js
    end
    redirect_to article_path(@article)
  end

  def destroy
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    @comment.destroy
    redirect_to article_path(@article)
  end
 
  private
    def authenticate
      authenticate_or_request_with_http_basic do |name, password|
        name == "admin" && password == "secret"
      end
    end
    
    def comment_params
      params.require(:comment).permit(:commenter, :body)
    end
end
