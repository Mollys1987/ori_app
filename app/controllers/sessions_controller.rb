class SessionsController < ApplicationController
  def new
  end
  
  def create
    p'1==========='
    user = User.find_by(nickname: params[:session][:nickname])
    p'2============='
    login_result = BCrypt::Password.new(user.answer_digest).is_password?(params[:session][:answer_digest])
    p'3==============='
    if user && login_result
    p'4================'
      log_in user
    p'5=============='
      remember(user)
    p'6================'
      redirect_to p_index_path
    else
      p'7====================='
      flash.now[:danger] = 'ニックネームまたは質問の答えが間違っています'
      render 'new'
    end
  end
  
  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
  
end
