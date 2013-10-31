class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
    @topic = Topic.find(params[:topic_id])
  end

  def new
    @topic = Topic.find(params[:topic_id])
    @post = Post.new
    authorize! :create, Post, message: "Yo ass need ta be a member ta create a freshly smoked up post. "
  end

  def create
    @topic = Topic.find(params[:topic_id])
    @post = current_user.posts.build(params[:post])
    @post.topic = @topic
    authorize! :create, @post, message: "Yo ass need ta be signed up ta do dis shit."
    if @post.save
      flash[:notice] = "Yo crazy-ass post was saved. Y'all KNOW dat shit, muthafucka! "
      redirect_to @post
    else
      flash[:error] = "There was a error savin tha post. Please try again."
      render :new
    end
  end

  def edit
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:id])
    authorize! :edit, @post, message: "Yo ass need ta own tha post ta edit dat shit."
  end

  def update
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:id])
    authorize! :update, @post, message: "Yo ass need ta own tha post ta edit dat shit."
    if @post.update_attributes(params[:post])
      flash[:notice] = "Yo crazy-ass post was updated."
      redirect_to @post
    else
      flash[:error] = "There was a error savin tha post. Please try again."
      render :edit
    end
  end
end
