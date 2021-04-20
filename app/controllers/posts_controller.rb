class PostsController < ApplicationController
  # index post list
  def index
    @posts = PostsService.postList
    respond_to do |format|
      format.html
      format.csv { send_data @posts.to_csv }
    end
  end

  # Post Detail
  def show
    @post = PostsService.getPostById(params[:id])
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

  # Edit Post Form
  def edit
    @post = PostsService.getPostById(params[:id])
  end

  # Update post
  def update
    isUpdatePost = PostsService.updatePost(post_params)
    if isUpdatePost
      redirect_to root_path
    else
      render :new
    end
  end

  def destroy
    PostsService.deletePost(params[:id])
    redirect_to root_path
  end

  def import
    Post.import(params[:file])
    redirect_to root_path, notice: "CSV uploaded"
  end

  def upload
  end

  private

  # post parameters
  def post_params
    params.require(:post).permit(:id, :title, :description, :status, :create_user_id, :updated_user_id, :updated_at)
  end
end
