require_relative 'scrapper/townhalls_scrapper'
require_relative 'mailer/mailer'
require 'CSV'

def perform_global

  perform_scrapper(["nord", "gironde", "landes"])

  perform_mailer('database/townhalls.csv', "mailer/message.html.erb")

  # perform_twitteritoss !!

end

perform_global()
