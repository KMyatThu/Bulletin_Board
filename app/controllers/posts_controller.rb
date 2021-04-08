class PostsController < ApplicationController
  # index post list
  def index
    @posts = PostsService.postList
  end

  # Post Detail
  def show
    @post = PostsService.postDetail(params[:id])
  end

  # New Post form
  def new
    @post = Post.new
  end

  # Create a new Post
  def create
    isSavePost = PostsService.createPost(post_params)
    if isSavePost
      redirect_to root_path
    else
      render :new
    end
  end

  private

  # post parameters
  def post_params
    params.require(:post).permit(:title, :description, :status, :create_user_id, :updated_user_id, :updated_at)
  end
end
