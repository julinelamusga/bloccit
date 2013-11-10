class CommentsController < ApplicationController
  def create
    authorize! :create, Comment, message: "Yo ass need ta be signed up ta do dis shit."
    
    @comment = current_user.comments.build(params[:comment])
    @post = Post.find(params[:post_id])
    @comment.post = @post


    if @comment.save
        flash[:notice] = "Yo crazy-ass comment was saved. Y'all KNOW dat shit, muthafucka! "
    else
        flash[:error] = "There was a error savin tha comment. Please try again."
    end
    redirect_to @post
  end

  def destroy
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.find(params[:post_id])

    @comment = @post.comments.find(params[:id])

    authorize! :destroy, @comment, message: "Yo ass need ta own tha comment ta delete dat shit."
    if @comment.destroy
      flash[:notice] = "Comment was removed sucka."
      redirect_to [@topic, @post]
    else
      flash[:error] = "Comment couldn't be deleted. Y'all KNOW dat shit! This type'a shiznit happens all tha time. Try again.
"
      redirect_to [@topic, @post]
    end
  end
end
