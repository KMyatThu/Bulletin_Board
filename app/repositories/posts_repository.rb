class PostsRepository
  # function: Get All Post List
  # return: posts
  def self.getPostList(role,id)
    if role == '0'
      @posts = Post.where(deleted_user_id: nil)
    else
      @posts = Post.where(deleted_user_id: nil).where(create_user_id: id)
    end
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
  def self.deletePost(post,deleted_user_id)
    post.update_attribute(:deleted_at, Time.now)
    post.update_attribute(:deleted_user_id, deleted_user_id)
  end

  # function: search post by keyword
  # params: keyword
  # return: posts
  def self.searchPostbyKeyWord(keyword)
    posts = Post.where(deleted_user_id: nil).where("title like ? or description like ?", "%" + keyword + "%", "%" + keyword + "%")
  end
end