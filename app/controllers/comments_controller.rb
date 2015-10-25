class CommentsController < ApplicationController

  before_action :find_comment_and_post, except: [:new, :create, :index]

  def index
    @comments = Comment.all
    @post = Post.find(params[:post_id])
  end
  def show
    redirect_to post_path(@post)
  end
  def new
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      redirect_to post_path(@post)
    else
      redirect_to posts_path
    end
  end

  def edit
  end

  def update
    if @comment.update(comment_params)
      redirect_to post_path
    else
      render :edit
    end
  end
  def destroy
    @comment.destroy
    redirect_to post_path(@post)
  end

  private
  def comment_params
    params.require(:comment).permit(:body)
  end
  def find_comment_and_post
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
  end
end
