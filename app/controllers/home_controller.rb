class HomeController < ApplicationController

  def index
  end

  def success 
  end

  def callback
  	auth = request.env["omniauth.auth"]
		user = FbGraph::User.new('magizh', :access_token => auth[:credentials][:token])
		user = user.fetch
		feed = user.feed
		while (Time.now.utc - feed.first.created_time)/3600 < 48
			feed.each do |p|
				if p.raw_attributes[:message] && 	(Time.now.utc - p.created_time)/3600 < 48
					if p.raw_attributes[:message].include? 'appy'
						p.like!(
	  					:access_token => auth[:credentials][:token]
						)
						p.comment!(
	  					:access_token => auth[:credentials][:token],
	  					:message => "Thanks :) from Magi's Bot http://magibday.cloudfoundry.com/ try this app on ur bday to say thanks to everyone in one click ;)"
						)		
						puts p.raw_attributes[:message]
					end
				end
			end
			feed = feed.next
		end
	  redirect_to "/success"
  end 

end
