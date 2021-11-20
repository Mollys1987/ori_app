class ConsultationsMailer < ApplicationMailer

  def send_mail(consultation)
    @consultation = consultation
    mail(
      from: ENV['ADD'],
      to:   ENV['ADD'],
      subject: 'お問い合わせ通知'
    )
  end
end
