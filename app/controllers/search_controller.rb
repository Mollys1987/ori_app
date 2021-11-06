class SearchController < ApplicationController
  def search
    p "==========="
    p params
    p "==========="
    @multis = User.where('key_word1 LIKE ? or key_word2 LIKE ? or key_word3 LIKE ?', "%#{params[:multi]}%", "%#{params[:multi]}%", "%#{params[:multi]}%")
    # if params[:nickname] or params[:area] or params[:title].present?
    #   @users = User.where('nickname LIKE ?', "%#{params[:nickname]}%")
    #   @areas = User.where('city LIKE ?', "%#{params[:city]}%")
    #   @posts = Post.where('title LIKE ?', "%#{params[:title]}%")
    # else
    #   @multis = User.none
    #   @users = User.none
    #   @areas = User.none
    #   @posts = Post.none
    #   # flash[:notice] = "一致する結果がありません"
    # end
  end
  
  def s_ajax
    
  end
  
  def result
    p "==========="
    p params
    p "==========="
    if params[:nickname]
      @users = User.where('nickname LIKE ?', "%#{params[:nickname]}%")
      respond_to do |format|
        format.json { render json: {users: @users} }
      end
    else
      @users = User.none
    end
    if params[:city]
      @cities = User.where('city LIKE ?', "%#{params[:city]}%")
      respond_to do |format|
        format.json { render json: {cities: @cities} }
      end
    end
    if params[:key]
     @keies = User.where('key_word1 LIKE ? or key_word2 LIKE ? or key_word3 LIKE ?', "%#{params[:key]}%", "%#{params[:key]}%", "%#{params[:key]}%")
      respond_to do |format|
        format.json { render json: {keies: @keies} }
      end
    end
    if params[:title]
      @titles = Post.where('title LIKE ?', "%#{params[:title]}%").as_json(include: :user)
      respond_to do |format|
        format.json { render json: {titles: @titles} }
      end
    end
    if params[:p_key]
      @p_keies = Post.where('key_word1 LIKE ? or key_word2 LIKE ? or key_word3 LIKE ? or key_word4 LIKE ? or key_word5 LIKE ?',
                            "%#{params[:p_key]}%", "%#{params[:p_key]}%", "%#{params[:p_key]}%", "%#{params[:p_key]}%", "%#{params[:p_key]}%"
                            ).as_json(include: :user)
      respond_to do |format|
        format.json { render json: {pkeies: @p_keies} }
      end
    end
  end
  
end