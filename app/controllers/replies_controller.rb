class RepliesController < ApplicationController
  def create
    @comment = Comment.find(params[:comment_id])
    @reply = @comment.replies.build(reply_params)
    @reply.user_id = current_user.id
    if @reply.save
      @comment.create_notification_reply!(current_user, @reply.id)
      flash[:success] = "コメントを作成しました"
      redirect_back(fallback_location: root_path)
    else
      redirect_back(fallback_location: root_path)
    end
  end
  
  def destroy
    p params
    reply = Reply.find_by(id: params[:id])
    reply.destroy
    flash[:success] = "コメントを削除しました"
    redirect_back(fallback_location: root_path)
  end
  
  private
  def reply_params
    params.require(:reply).permit(:re_comment, :user_id, :comment_id)
  end
  
  def re_params
    params.require(:reply).permit(:re_comment, :user_id, :reply_id, :comment_id)
  end
  
end
