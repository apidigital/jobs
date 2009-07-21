#!/usr/bin/env ruby

# You might want to change this
ENV["RAILS_ENV"] ||= "development"

require File.dirname(__FILE__) + "/../../config/environment"

$running = true
Signal.trap("TERM") do 
  $running = false
end

while($running) do
	ninetydays = Time.now - 7776000
	@submissions = Submission.find(:all, :conditions => ["created_at <= ? AND consider_for_interview = 0", ninetydays.to_formatted_s(:db)])
#   ActiveRecord::Base.logger.info "#{@submissions.count} old submissions found."
	@submissions.each do |submission|
		if submission.destroy
			ActiveRecord::Base.logger.info "Successfully removed #{submission.user.profile.firstname} #{submission.user.profile.lastname}'s application for #{submission.position.name}"
		else
			ActiveRecord::Base.logger.info "Could not removed #{submission.user.profile.firstname} #{submission.user.profile.lastname}'s application for #{submission.position.name}"
		end
	end
  sleep 86400
end