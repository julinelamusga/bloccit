class TopicsController < ApplicationController
  def index
    @topics = Topic.all
  end

  def new
    @topic = Topic.new
    authorize! :create, @topic, message: "Back up! Yo ass need ta be a admin ta do dis shit."
  end

  def show
    @topic = Topic.find(params[:id])
    @posts = @topic.posts
  end

  def edit
    @topic = Topic.find(params[:id])
    authorize! :update, @topic, message: "Woah, homie! Yo ass need ta be a admin ta do dis shit."
  end

  def create
    @topic = Topic.new(params[:topic])
    authorize! :create, @topic, message: "Yo ass has GOT to be an admin to do dat."
    if @topic.save
      flash[:notice] = "Yo topic waz saved dawg."
      redirect_to @topic
    else
      flash[:error] = "There be an error. Try again son."
      render :new
    end
  end

  def update
    @topic = Topic.find(params[:id])
    authorize! :update, @topic, message: "This ain't yo topic!"
    if @topic.updated_attributes(params[:topic])
      redirect_to @topic
    else
      flash[:error] = "There be an error. Try again homez."
      render :edit
    end
  end
end
