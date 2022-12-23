class FavoritesController < ApplicationController
  def favorite_index
    @user = User.find(params[:id])
    @post = @user.post

    favorites = Favorite.where(user_id: current_user.id).pluck(:post_id)
    @favorite_user = Post.find(favorites)
  end

  def create
    favorite = current_user.favorites.create(post_id: params[:post_id])
    redirect_to posts_path, notice: "#{favorite.post.user.name}さんのブログをお気に入り登録しました"
  end

  def destroy
    favorite = current_user.favorites.find_by(id: params[:id]).destroy
    redirect_to posts_path, notice: "#{favorite.post.user.name}さんのブログをお気に入り解除しました"
  end
  
end
