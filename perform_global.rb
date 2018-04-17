require_relative 'scrapper/townhalls_scrapper'
require_relative 'mailer/mailer'
require_relative 'twitter/townhalls_added_to_db'
require_relative 'twitter/townhalls_follower'
require 'gmail'
require 'dotenv'
Dotenv.load('.env')
require 'CSV'


def perform_global

  perform_scrapper(["nord", "gironde", "landes"])

  perform_mailer('database/townhalls.csv', "mailer/message.html.erb")

  perform_handler()

  perform_follower()

end

perform_global()
