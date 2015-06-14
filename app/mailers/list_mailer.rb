class ListMailer < ActionMailer::Base
  default from: "from@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.list_mailer.email_list.subject
  #
  def email_invoice(invoice, sender_email, to_email, message)
    @invoice = invoice
    @message = message
    @sender = sender_email
    mail to: to_email, subject: "Here is your invoice from Deborah Anderson!"
  end
end
