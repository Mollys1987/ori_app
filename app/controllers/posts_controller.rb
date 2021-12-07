class PostsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :index, :show]
  before_action :correct_user,   only: [:update, :destroy]
  
  def new
    @post = Post.new
  end
  
  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "投稿成功しました"
      redirect_to p_index_path
    else
      render :new
    end
  end
  
  def index
    @posts = Post.order("RANDOM()").all
    @posts = Kaminari.paginate_array(@posts).page(params[:page])
  end
  
  def like
    @user = current_user
    @follow_users = @user.following
    # @follow_users.each do |fu|
    #   fu.posts.each do |lp|
    #     @posts = Kaminari.paginate_array(lp).page(params[:page]).per(10)
    #   end
    # end
  end
  
  def show
    p 'show_start========================='
    @post = Post.find(params[:id])
    @like = Like.new
    @comments = @post.comments
    @comment = Comment.new
    @reply = Reply.new
    p 'end========================='
  end
  
  def edit
    @post = Post.find(params[:id])
  end
  
  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(post_params)
      flash[:success] = "投稿内容を更新しました"
      redirect_to p_show_path
    else
      render :edit
    end
  end
  
  def destroy
    p 'des_start========================='
    @post = Post.find_by(id: params[:id])
    @post.destroy
    flash[:success] = "投稿を削除しました"
    redirect_to u_show_path(current_user)
    p 'des_end========================='
  end
  
  def pic_des1
    p 'des_start========================='
    @post = Post.find_by(id: params[:id])
    @post.remove_picture1!
    @post.save
    flash[:success] = "写真１を削除しました"
    redirect_to p_edit_path(@post.id)
    p 'des_end========================='
  end
  
  def pic_des2
    p 'des_start========================='
    @post = Post.find_by(id: params[:id])
    @post.remove_picture2!
    @post.save
    flash[:success] = "写真２を削除しました"
    redirect_to p_edit_path(@post.id)
    p 'des_end========================='
  end
  
  def pic_des3
    p 'des_start========================='
    @post = Post.find_by(id: params[:id])
    @post.remove_picture3!
    @post.save
    flash[:success] = "写真３を削除しました"
    redirect_to p_edit_path(@post.id)
    p 'des_end========================='
  end
  
  def pic_des4
    p 'des_start========================='
    @post = Post.find_by(id: params[:id])
    @post.remove_picture4!
    @post.save
    flash[:success] = "写真４を削除しました"
    redirect_to p_edit_path(@post.id)
    p 'des_end========================='
  end
  
  def pic_des5
    p 'des_start========================='
    @post = Post.find_by(id: params[:id])
    @post.remove_picture5!
    @post.save
    flash[:success] = "写真５を削除しました"
    redirect_to p_edit_path(@post.id)
    p 'des_end========================='
  end
  
  def mov_des
    p 'des_start========================='
    @post = Post.find_by(id: params[:id])
    @post.remove_video!
    @post.save
    flash[:success] = "動画を削除しました"
    redirect_to p_edit_path(@post.id)
    p 'des_end========================='
  end
  
  private
    def post_params
      params.require(:post).permit(:title, :content, :user_id, :picture1, :picture2,
                                   :picture3, :picture4, :picture5, :video,
                                   :key_word1, :key_word2, :key_word3, :key_word4,
                                   :key_word5)
    end
    
    def correct_user
      @post = current_user.posts.find_by(id: params[:id])
      redirect_to root_url if @post.nil?
    end
end