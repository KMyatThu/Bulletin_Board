class PostsRepository
  # function: Get All Post List
  # return: posts
  def self.getPostList
    @posts = Post.all
  end

  # function: Get Post Detail
  # params: id
  # return: post
  def self.getPostById(id)
    @post = Post.find(id)
  end

  # function: Create new Post
  # params: post
  # return: isSavePost(boolean)
  def self.createPost(post)
    isSavePost = post.save
  end

  # function Update Post
  # params post
  # return isUpdatePost(boolean)
  def self.updatePost(post, post_params)
    isUpdatePost = post.update(post_params)
  end

  # function: delete post
  # params: id
  def self.deletePost(post)
    post.destroy
  end

  # function: search post by keyword
  # params: keyword
  # return: posts
  def self.searchPostbyKeyWord(keyword)
    posts = Post.where("title like ? or description like ?", "%" + keyword + "%", "%" + keyword + "%")
  end
end