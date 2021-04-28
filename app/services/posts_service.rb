class PostsService
    # post list
    def self.postList
      @posts = PostsRepository.getPostList
    end

    # function post detail
    # params id
    # return post
    def self.getPostById(id)
      @post = PostsRepository.getPostById(id)
    end

    # Create new Post
    # params post_params
    # return isSavePost
    def self.createPost(post_params,current_user)
      post = Post.new(post_params)
      post.status = 1 # default when create
      post.create_user_id = current_user.id
      post.updated_user_id = current_user.id
      post.updated_at = Time.now
      isSavePost = PostsRepository.createPost(post)
    end

    # Update Post
    # params post
    # return isUpdatePost
    def self.updatePost(post_params,current_user)
      post = getPostById(post_params[:id])
      post.updated_at = Time.now
      post.updated_user_id = current_user.id
      isUpdatePost = PostsRepository.updatePost(post,post_params)
    end

    # function Delete Post
    # params id
    def self.deletePost(post_id,deleted_user_id)
      post = getPostById(post_id)
      PostsRepository.deletePost(post,deleted_user_id)
    end

    # function: post search
    # params: keyword
    # return: posts
    def self.searchPost(keyword)
      posts = PostsRepository.searchPostbyKeyWord(keyword)
    end
end