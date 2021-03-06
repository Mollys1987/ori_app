class CommentsController < ApplicationController
  def create
    p 'comme_start==============='
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      @post.create_notification_comment!(current_user, @comment.id)
      flash[:success] = "コメントを作成しました"
      redirect_back(fallback_location: root_path)
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    p params
    comment = Comment.find_by(id: params[:id])
    comment.destroy
    flash[:success] = "コメントを削除しました"
    redirect_back(fallback_location: root_path)
  end

  private
  def comment_params
    params.require(:comment).permit(:content, :user_id, :post_id, :parent_id)
  end
end
