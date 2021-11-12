class SessionsController < ApplicationController
  def new
  end
  
  def create
    p'1====================='
    if params[:session][:nickname].presence && params[:session][:answer_digest].presence
    p'2====================='
      user = User.find_by(nickname: params[:session][:nickname])
    p'3====================='
      if user == nil
        flash[:danger] = 'ユーザー登録がありません'
        redirect_back(fallback_location: root_path)
        return
      else
        login_result = BCrypt::Password.new(user.answer_digest).is_password?(params[:session][:answer_digest])
      end
    end
    p'5====================='
    if user && login_result
      p'6====================='
      log_in user
      remember(user)
      redirect_to p_index_path
    else
      p'7====================='
      flash.now[:danger] = '未入力または入力内容が間違っています'
      p'8====================='
      render 'new'
    end
  end
  
  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
  
end
