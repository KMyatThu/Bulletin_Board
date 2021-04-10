class PostsRepository
  # Get All Post List
  def self.getPostList
    @posts = Post.all
  end

  # Get Post Detail
  def self.getPostById(id)
    @post = Post.find(id)
  end

  # Create new Post
  def self.createPost(post)
    isSavePost = post.save
  end

  # function Update Post
  # params post
  # return isUpdatePost
  def self.updatePost(post, post_params)
    isUpdatePost = post.update(post_params)
  end

  # function delete post
  # params id
  def self.deletePost(post)
    post.destroy
  end
end