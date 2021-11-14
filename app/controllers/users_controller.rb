class UsersController < ApplicationController
  before_action :logged_in_user, only: [:show, :index,:update,
                                        :following, :followers]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy
  
  def new
    @user = User.new
  end
  
  def create
    p params
    @user = User.new(user_params)
    @user.answer_digest = BCrypt::Password.create(params[:user][:answer_digest])
    if @user.save
      log_in @user
      remember(@user)
      flash[:success] = "登録が完了しました"
      redirect_to p_index_path
    else
      render :new
    end
  end
  
  def show
    p'show============'
    @user = User.find(params[:id])
    p'show_end=========='
  end
  
  def index
    @admin = User.find(1)
    @users = User.order("RANDOM()").all
    @users = Kaminari.paginate_array(@users).page(params[:page])
  end
  
  def edit
    @user = User.find(current_user.id)
  end
  
  def update
    @user = User.find(current_user.id)
    if @user.update_attributes(user_params)
      flash[:success] = "プロフィールを更新しました"
      redirect_to u_show_path(current_user.id)
    else
      render 'edit'
    end
  end
  
  def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following
    # .paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers
    # .paginate(page: params[:page])
    render 'show_follow'
  end
  
  def destroy
    p params
    user = User.find_by(id: params[:id])
    user.destroy
    flash[:success] = "ユーザーを削除しました"
    redirect_back(fallback_location: root_path)
  end
  
  private
    def user_params
      params.require(:user).permit(:nickname, :age, :sex, :prefucture,
                                   :city, :classification, :nursing, :status,
                                   :key_word1, :key_word2, :key_word3,
                                   :answer_digest, :profile_image)
    end
    
    def correct_user
      @user = User.find(current_user.id)
      redirect_to(root_url) unless current_user?(@user)
    end
    
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
