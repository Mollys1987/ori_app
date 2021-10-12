class ApplicationController < ActionController::Base
  include SessionsHelper
  # before_action :message_notification
   
  # def message_notification
  #   @message_notification_count = DirectMessage.where(to_user_id: current_user.id,to_user_opentime: nil).count
  # end
  
  private

    # ユーザーのログインを確認する
    def logged_in_user
      unless logged_in?
        flash[:danger] = "Please log in."
        redirect_to root_path
      end
    end
end
