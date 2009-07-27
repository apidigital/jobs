class DenialMailer < ActionMailer::Base
  def denied(submission)
  	denial_message = Message.find_by_title('denial_message')
  	recipients 	submission.user.email
  	from				"jobs@api-digital.com"
  	subject			"Thank you for Applying"
  	body				:submission => submission, :denial_message => denial_message
  end
end
