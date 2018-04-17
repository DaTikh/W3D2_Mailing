require 'gmail'
require 'dotenv'
Dotenv.load('../.env')
require 'CSV'

def go_through_all_the_lines(url)

  townhalls_list = CSV.read(url)
  townhalls_lines = []
  townhalls_emails = []
  i = 1

  townhalls_list.each do |line|
    townhalls_lines << line[0].split(";")
  end

  return townhalls_lines

end

def get_the_email_html()

  message = File.open("message.html.erb")
  return message

end

def send_email_to_line(list)

  # Authentification session with .env

  gmail = Gmail.connect(ENV['USERNAME'], ENV['PASSWORD'])

  return

end

def perform
  townhalls_lines = go_through_all_the_lines('temp_list.csv')

  # townhalls_lines.each do |line|



  # while i < townhalls_lines.length do
  #   townhalls_emails << townhalls_lines[i][2]
  #   i += 1
  # end

  # return townhalls_emails

  get_the_email_html()


end

print perform()
