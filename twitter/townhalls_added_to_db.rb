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

def handle_search(list)
  client = Twitter::REST::Client.new do |config|
    config.consumer_key        = ENV['TWITTER_CONSUMER']
    config.consumer_secret     = ENV['TWITTER_CONSUMER_SECRET']
    config.access_token        = ENV['TWITTER_TOKEN']
    config.access_token_secret = ENV['TWITTER_TOKEN_SECRET']
  end
  list.each do |line|
    if line[0] == "name"
    elsif client.user_search("ville #{line[0]}").first
      line[3] = client.user_search("ville #{line[0]}").first.screen_name
    else
      line[3] = ""
    break if line[0] == "BUDOS"
    end
  end
  list
  return final_list = list
end

def to_csv(final_list)
  CSV.open("../database/townhalls.csv", "wb") do |csv|
    csv << ["name", "zipcode", "email", "handle"]
    final_list.each do |x|
    csv << x
    end
    end
  puts "Base de données mise à jour !!"
end

def perform_handler()
  list = go_through_all_the_lines(url)
  final_list = handle_search(list)
  to_csv(final_list)
end
