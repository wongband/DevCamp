class TopicsController < ApplicationController
  layout 'blog'

  def index
  	@topics = Topic.all
  end

  def show
  	@topics = Topic.find(params[:id])

  	if logged_in?(:site_admin)
      @blogs = @topics.blogs.all.page(params[:page]).per(5)
    else
      @blogs = @topics.blogs.published.page(params[:page]).per(5)
    end
  end
end