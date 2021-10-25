class SessionsController < ApplicationController
  def new
  end
  
  def create
    user = User.find_by(nickname: params[:session][:nickname])
    if user && user.authenticate(params[:session][:password][:answer])
      log_in user
      remember(user)
      redirect_to p_index_path
    else
      flash.now[:danger] = 'ニックネームまたはパスワードが間違っています'
      render 'new'
    end
  end
  
  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
  
end
