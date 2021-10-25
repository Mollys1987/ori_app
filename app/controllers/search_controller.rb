class SearchController < ApplicationController
  def search
    if params[:nickname] or params[:area] or params[:title].present?
      @users = User.where('nickname LIKE ?', "%#{params[:nickname]}%")
      @areas = User.where('city LIKE ?', "%#{params[:city]}%")
      @posts = Post.where('title LIKE ?', "%#{params[:title]}%")
    else
      @users = User.none
      @areas = User.none
      @posts = Post.none
      # flash[:notice] = "一致する結果がありません"
    end
  end
end
