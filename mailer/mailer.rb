require 'gmail'
require 'dotenv'
Dotenv.load('../.env')
require 'CSV'

# Tri du CSV appelé dans l'URL, et retourne un array propre pour traitement dans d'autre fonction
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

#
def get_the_email_html(line)
  # Addressage du fichier message
  message = File.read("message.html.erb")
  return message
end

def send_email_to_line(line)
  # Appel du message dans la fonction envoyer email
  content = get_the_email_html(line)
  # Authentification session with .env
  gmail = Gmail.connect(ENV['USERNAME'], ENV['PASSWORD'])
  # Envoi du mail à l'email de l'array rentré dans la fonction
  gmail.deliver do
    to "#{line[2]}"
    subject "Promo de THP spécialement pour la Mairie de #{line[0]}!"
    html_part do
      content_type 'text/html; charset=UTF-8'
      body content
    end
  end
end

def perform
  townhalls_lines = go_through_all_the_lines('temp_list.csv')
  townhalls_lines.each do |line|
    if line[2] == "Email"
    else
      send_email_to_line(line)
      puts "#{line[2]} = send"
    end
  end
end

perform()
