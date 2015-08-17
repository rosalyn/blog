class ArticlesController < ApplicationController

  before_filter :authenticate, except: [:index, :show]
  before_filter :check_for_cancel, only: [:create, :update]

  def index
    @articles = Article.all.order('created_at DESC')
  end

  def show
    @article = Article.find(params[:id])
    @articles = Article.order("created_at DESC").limit(5).offset(1)
  end

  def new
    @article = Article.new
  end

  def edit
    @article = Article.find(params[:id])
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article
    else
      render 'new'
    end
  end

  def update
    @article = Article.find(params[:id])
    
    if @article.update(article_params)
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to articles_path
  end

  private
    def authenticate
      authenticate_or_request_with_http_basic do |name, password|
        name == "admin" && password == "secret"
      end
    end

    def check_for_cancel
      if (params.key?("cancel"))
        redirect_to articles_path
      end
    end

    def article_params
      params.require(:article).permit(:title, :text, tags_attributes: [:name])
    end
end
