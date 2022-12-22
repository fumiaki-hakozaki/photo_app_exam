class PostsController < ApplicationController
  def index
    @post = Post.all
  end

  def new
    if params[:back]
      @post = Post.new(post_params)
    else
      @post = Post.new
    end
  end

  def show
    @post = Post.find(params[:id])
    @favorite = current_user.favorites.find_by(post_id: @post.id)
  end

  def create
    @post = current_user.posts.build(post_params)
    if params[:back]
      render :new
    else 
      if @post.save
      PostMailer.post_mail(@post).deliver
      redirect_to posts_path, notice: "ブログを作成しました！！！"
      else
      render :new
      end
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to posts_path, notice: "ブログを編集しました！！"
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path, notice: "ブログ削除しました！"
  end


  def confirm
    @post = current_user.posts.build(post_params)
    render :new if @post.invalid?
  end


  private

    def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title,:content,:image,:image_cache)
  end

end
