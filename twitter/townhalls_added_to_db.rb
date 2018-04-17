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

  # On recherche le handle de chaque mairie.
def handle_search(list)
  # Connexion à l'API Twitter avec le Token renseigné dans le .env loadé.
  client = Twitter::REST::Client.new do |config|
    config.consumer_key        = ENV['TWITTER_CONSUMER']
    config.consumer_secret     = ENV['TWITTER_CONSUMER_SECRET']
    config.access_token        = ENV['TWITTER_TOKEN']
    config.access_token_secret = ENV['TWITTER_TOKEN_SECRET']
  end
  list.each do |line| # Pour chaque ligne du tableau :
    if line[0] == "name" # On skip la première.
    elsif client.user_search("ville #{line[0]}").first # Si on trouve un résultat on l'enregistre 4è valeur du tableau.
      line[3] = client.user_search("ville #{line[0]}").first.screen_name
    else # Si on ne trouve rien on enregistre un blanc.
      line[3] = ""
    break if line[0] == "BUDOS" # Pour pouvoir effectuer le test arrête à la mairie BUDOS, sinon on finira par se faire kick de l'API Twitter...
#  Afin de continuer à faire tourner le script jusqu'à la fin il faudrait rescue les erreurs "Too many requests", mettre un sleep qui relancerait plus tard.
    end
  end
  list
  return final_list = list
end

  # On rappelle notre db pour enregistrer les handles trouvés.
def to_csv(final_list)
  CSV.open("../database/townhalls.csv", "wb") do |csv|
    csv << ["name", "zipcode", "email", "handle"]
    final_list.each do |x|
    csv << x
    end
    end
  puts "Base de données mise à jour !!"
end

  # Perform des trois méthodes.
def perform_handler()
  list = go_through_all_the_lines(url)
  final_list = handle_search(list)
  to_csv(final_list)
end
