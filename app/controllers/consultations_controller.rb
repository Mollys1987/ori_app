class ConsultationsController < ApplicationController
  
  def new
    p params
    @consultation = Consultation.new
  end

  def create
    p params
    @consultation = Consultation.new(cs_params)
    @consultation.sender_id = current_user.id
    @consultation.receiver_id = 1
    p @consultation
    if @consultation.save
      redirect_to accep_path
    else
      flash[:danger] = "送信失敗しました"
      render :new
    end
  end
  
  def accep
    
  end
  
  private
    def cs_params
      params.require(:consultation).permit(:title, :content, :sender_id)
    end
end
