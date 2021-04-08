class PostsRepository
  # Get All Post List
  def self.getPostList
    @posts = Post.all
  end

  # Get Post Detail
  def self.getPostDetail(id)
    @post = Post.find(id)
  end

  # Create new Post
  def self.createPost(post)
    isSavePost = post.save
  end
end