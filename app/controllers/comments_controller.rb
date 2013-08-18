class CommentsController < ApplicationController
  def create
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.find(params[:post_id])
    @comments = @post.comments
    @comment = current_user.comments.build(params[:comment])
    @comment.post = @post
    
    authorize! :create, @comment, message: "You need to be an admin to do that."
    if @comment.save
      flash[:notice] = "Comment was saved."
      redirect_to [@topic, @post]
    else
      flash[:error] = "There was an error saving the comment. Please try again."
      render :new
    end
  end

  def new
    @post = Post.find(params[:post_id])
    @topic = @post.topic
    @user = User.find(params[:user_id])
    @comment = Comment.new
  end

  def show
    @post = Post.find(params[:post_id])
    @topic = @post.topic
    @user = User.find(params[:user_id])
    @comment = Comment.find(params[:id])
  end

  def edit
  end
end
