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
end