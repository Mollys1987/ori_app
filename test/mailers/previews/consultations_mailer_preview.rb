# Preview all emails at http://localhost:3000/rails/mailers/consultations_mailer
class ConsultationsMailerPreview < ActionMailer::Preview
  def consultation
     consultation = Consultation.new(sender_id: 3, receiver_id: 1, title: "test", content: "text-test")
    
     ConsultationsMailer.send_mail(consultation)
  end
end
