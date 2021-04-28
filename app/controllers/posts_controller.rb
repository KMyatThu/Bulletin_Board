class PostsController < ApplicationController
  before_action :authorized
  # function: index(post List)
  # return: posts
  def index
    @posts = PostsService.postList
    respond_to do |format|
      format.html
      format.csv { send_data @posts.to_csv }
    end
  end

  # function: Post Detail
  # params: id
  # return: post
  def show
    @post = PostsService.getPostById(params[:id])
  end

  # function: new post
  # return: post(new)
  def new
    @post = Post.new
  end

  # function: post_form
  # params: post params
  # return: post
  def post_form
    @post = Post.new(post_params)
    unless @post.valid?
      render :new
    else
      redirect_to :action => "create_confirm", title: @post.title, description: @post.description
    end
  end

  # function: create_confirm
  # params: title,description
  # return: post
  def create_confirm
    @title = params[:title]
    @description = params[:description]
    @post = Post.new(title: @title, description: @description)
  end

  # function: create post
  # params: post_params
  def create
    isSavePost = PostsService.createPost(post_params,current_user)
    if isSavePost
      redirect_to root_path
    else
      render :new
    end
  end

  # function: Edit Post
  # params: id
  # return: post
  def edit
    @post = PostsService.getPostById(params[:id])
  end

  # function: post edit form
  # params: post params
  # return: post
  def post_edit_form
    @post = Post.new(post_params)
    unless @post.valid?
      render :edit
    else
      redirect_to :action => "update_confirm", title: @post.title, description: @post.description, state: @post.status, id: @post.id
    end
  end

  # function: update_confirm
  # params: title,description,status
  # return: post form
  def update_confirm
    @id = params[:id]
    @title = params[:title]
    @description = params[:description]
    @status = params[:state]
    @post = Post.new(title: @title, description: @description, status: @status, id: @id)
  end

  # function: Update post
  # params: post_params
  def post_update
    isUpdatePost = PostsService.updatePost(post_params,current_user)
    if isUpdatePost
      redirect_to root_path
    else
      render :new
    end
  end

  # function: Post Delete
  # params: id
  def destroy
    PostsService.deletePost(params[:id],current_user[:id])
    redirect_to root_path
  end

  # function: post import
  # params: file
  def import
    if (params[:file].nil?)
      flash.now[:notice] = "Please choose a file."
      render :upload
    else 
      Post.import(params[:file])
      redirect_to root_path, notice: "CSV uploaded"
    end
  end

  # function: post upload page
  def upload
  end

  # function: search post
  # params: params(keyword)
  # return: posts
  def search_post
    keyword = params[:keyword]
    @posts = PostsService.searchPost(keyword)
    render :index
  end

  private

  # post parameters
  def post_params
    params.require(:post).permit(:id, :title, :description, :status, :create_user_id, :updated_user_id, :updated_at)
  end
end
