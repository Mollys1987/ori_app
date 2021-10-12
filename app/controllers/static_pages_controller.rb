class StaticPagesController < ApplicationController

  def home
    if logged_in?
      redirect_to u_show_path(current_user.id)
    end
  end

end
