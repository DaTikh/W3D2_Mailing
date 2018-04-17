require 'rubygems'
require 'pry'
require 'csv'
require 'twitter'
require 'dotenv'

Dotenv.load("../.env")

url = '../database/townhalls.csv'

  # On appelle notre db et on la stocke dans un tableau.
def go_through_all_the_lines(url)
  list = CSV.read(url)
end

  # On follow chaque handle de notre db.
def townhall_follower(list)
  # Connexion à l'API Twitter avec le Token renseigné dans le .env loadé.
  client = Twitter::REST::Client.new do |config|
    config.consumer_key        = ENV['TWITTER_CONSUMER']
    config.consumer_secret     = ENV['TWITTER_CONSUMER_SECRET']
    config.access_token        = ENV['TWITTER_TOKEN']
    config.access_token_secret = ENV['TWITTER_TOKEN_SECRET']
  end
  list.each do |line| # Pour chaque ligne du tableau :
    if line[3] == "" || line[3] == "handle" # On skip la première ligne, ou celles qui sont vides.
    else
      client.follow("#{line[3]}") # On follow les handles trouvés précédemment.
    end
  end
end

  # Perform des deux méthodes.
def perform_follower()
  townhall_follower(go_through_all_the_lines(url))
end
