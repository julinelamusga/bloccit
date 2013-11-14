class TopicsController < ApplicationController
  def index
    @topics = Topic.visible_to(current_user).paginate(page: params[:page], per_page: 10)
  end

  def new
    @topic = Topic.new
    authorize! :create, @topic, message: "Back up! Yo ass need ta be a admin ta do dis shit."
  end

  def show
    @topic = Topic.find(params[:id])
    authorize! :read, @topic, message: "Yo ass need ta be signed in ta do that ish."
    @posts = @topic.posts.paginate(page: params[:page], per_page: 10)
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

  def destroy
    @topic = Topic.find(params[:id])
    name = @topic.name
    authorize! :destroy, @topic, message: "Yo ass need ta own tha topic ta delete dat shit."
    if @topic.destroy
      flash[:notice] = "\"#{name}\" was deleted sucka."
      redirect_to topics_path
    else
      flash[:error] = "There be an error deleting yo topic."
      render :show
    end
  end
end
