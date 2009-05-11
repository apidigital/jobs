class Forgotten < ActionMailer::Base

  def confirm(recipient, message, newpass, uname, sent_at = Time.now)
    @putpass = newpass
    @subject    = 'Your Password Has Been Reset'
    @recipients = recipient
    @from       = 'no-reply@jobs.apid.com'
    @sent_on    = sent_at
    @headers    = {}
    @body["message"] = message
    @body["account"] = uname
  end

  def sent(sent_at = Time.now)
    @subject    = 'Forgotten#sent'
    @body       = {}
    @recipients = ''
    @from       = ''
    @sent_on    = sent_at
    @headers    = {}
  end
end
