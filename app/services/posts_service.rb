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
    def self.createPost(post_params)
      post = Post.new(post_params)
      post.status = 1 # default when create
      post.create_user_id = 1 #It will change when user is created
      post.updated_user_id = 1 #It will change when user is created
      post.updated_at = Time.now
      isSavePost = PostsRepository.createPost(post)
    end

    # Update Post
    # params post
    # return isUpdatePost
    def self.updatePost(post_params)
      post = getPostById(post_params[:id])
      post.updated_at = Time.now
      isUpdatePost = PostsRepository.updatePost(post,post_params)
    end

    # function Delete Post
    # params id
    def self.deletePost(id)
      post = getPostById(id)
      PostsRepository.deletePost(post)
    end

    # function: post search
    # params: keyword
    # return: posts
    def self.searchPost(keyword)
      posts = PostsRepository.searchPostbyKeyWord(keyword)
    end
end