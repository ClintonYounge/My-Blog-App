class CustomDeviseMailer < Devise::Mailer
  def confirmation_instructions(record, token, _opts = {})
    # Log the confirmation email action instead of sending an email
    logger.info "Confirmation email sent to #{record.email} with confirmation token #{token}"
  end
end
