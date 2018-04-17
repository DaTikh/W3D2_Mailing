require 'rubygems'
require 'pry'
require 'csv'
require 'twitter'
require 'dotenv'

Dotenv.load("../.env")

url = '../database/townhalls.csv'

def go_through_all_the_lines(url)
  list = CSV.read(url)
end

def townhall_follower(list)
  client = Twitter::REST::Client.new do |config|
    config.consumer_key        = ENV['TWITTER_CONSUMER']
    config.consumer_secret     = ENV['TWITTER_CONSUMER_SECRET']
    config.access_token        = ENV['TWITTER_TOKEN']
    config.access_token_secret = ENV['TWITTER_TOKEN_SECRET']
  end
  list.each do |line|
    if line[3] == "" || line[3] == "handle"
    else
      client.follow("#{line[3]}")
    end
  end
end

def perform_follower()
  townhall_follower(go_through_all_the_lines(url))
end
