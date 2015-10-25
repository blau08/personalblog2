class PostsController < ApplicationController

  before_action :authenticate_user!, except: [:index]
  before_action :set_default, only: [:new, :create, :edit, :update, :destroy, :index]

  def new
    @post = Post.new
  end

  def show
    @post = Post.find(params[:id])
    @comments = Comment.new
  end

  def create
    @posts = Post.all
    @post = Post.new(post_params)
    @post.user = @user

    if (@post.save)
      render :index
    else
      render :new
    end
  end

  def index
    @posts = Post.all
  end

  def destroy
    @post = Post.find(params[:id])
    if current_user == @post.user
      @post.destroy
      redirect_to user_path(@user)
    else
      flash[:alert] = "This is not your post! This post belongs to #{@post.user.email}"
      redirect_to :back
    end
  end

private
 def set_default
   @user = current_user
 end

private
  def post_params
    params.require(:post).permit(:description)
  end
end
