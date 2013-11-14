class FavoriteMailer < ActionMailer::Base
  default from: "juline.lamusga@gmail.com"

  def new_comment(user, post, comment)
    @user = user
    @post = post
    @comment = comment

    #New Headers
    headers["Message-ID"] = "<comments/#{@comment.id}@your-app-name.example>"
    headers["In-Reply-To"] = "<post/#{@post.id}@your-app-name.example>"
    headers["References"] = "<post/#{@post.id}@your-app-name.example>"

    mail(to: user.email, subject: "There be a new comment on #{post.title}")
  end
end
