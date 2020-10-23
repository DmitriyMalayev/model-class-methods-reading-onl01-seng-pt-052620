class PostsController < ApplicationController
  def index
    @authors = Author.all  #Provide a list of authors tot he view for the filter control 
    
    if !params[:author].blank? #This section filters the @posts list based on user input 
      @posts = Post.by_author(params[:author])
      # @posts = Post.where(author: params[:author])

      elsif !params[:date].blank?
        if params[:date] == "Today"
          # @posts = Post.where("created_at >=?", Time.zone.today.beginning_of_day)
          @posts = Post.from_today 
        else 
          # @posts = Post.where("created_at <?", Time.zone.today.beginning_of_day)
          @posts = Post.old_news 
        end 
      else  
        @posts = Post.all  #If no filters are applied, show all posts. 
      end 
  end


  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(params)
    @post.save
    redirect_to post_path(@post)
  end

  def update
    @post = Post.find(params[:id])
    @post.update(params.require(:post))
    redirect_to post_path(@post)
  end

  def edit
    @post = Post.find(params[:id])
  end
end
