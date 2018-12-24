module SocialTool
	def self.twitter_search
		client = Twitter::REST::Client.new do |config|
		  config.consumer_key        = ENV.fetch("Twitter_CONSUMER_KEY")
		  config.consumer_secret     = ENV.fetch("Twitter_CONSUMER_SECRET")
		  config.access_token        = ENV.fetch("Twitter_ACCESS_TOKEN")
		  config.access_token_secret = ENV.fetch("Twitter_ACCESS_SECRET")
		end

		client.search("#coding", result_type: 'recent').take(6).collect do |tweet|
			"#{tweet.user.screen_name}: #{tweet.text}"
		end
	end
end