require_relative 'scrapper/townhalls_scrapper'
require_relative 'mailer/townhalls_mailer'
require_relative 'twitter/townhalls_added_to_db'
require_relative 'twitter/townhalls_follower'
require 'gmail'
require 'dotenv'
Dotenv.load('.env')
require 'CSV'


def perform_global
    # On lance toute l'acquisition des e-mails des départements souhaités avec l'appel de la fonction
    # perform_scrapper issu du fichier townhalls_scrapper.rb
  perform_scrapper(["nord", "gironde", "landes"])
    # On lance l'envoi des messages aux e-mails préalablement chargés par le perform_scrapper
    # Le perform_mailer est issu du fichier mailer.rb
  perform_mailer('database/townhalls.csv', "mailer/message.html.erb")
    # On lance la recherche générale des comptes twitter des villes des départements souhaités
    # Le perform_handler est issu du fichier townhalls_added_to_db
  perform_handler()
    # On fait suivre toutes les personnes qui sont concernées par les comptes twitter précédemment récupérés
    # Le perform_follower est issu du fichier townhalls_follower
  perform_follower()
end

perform_global()
