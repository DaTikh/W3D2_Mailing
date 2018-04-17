require 'gmail'
require 'dotenv'
Dotenv.load('../.env')
require 'CSV'

# Affectation du CSV appelé dans l'URL, et retourne l'array propre
def go_through_all_the_lines(url)
  townhalls_list = CSV.read(url)
  return townhalls_list
end

# Lie le message qui sera dans le mail
def get_the_email_html
  # Addressage du fichier message
  message = File.read("message.html.erb")
  return message
end

# Appelle le modèle de message à envoyer, s'authentifie avec les IDs rentrés dans le .env,
# et envoie à chaque adresse de mairie le mail !
def send_email_to_line(line)
  # Appel du message dans la fonction envoyer email
  content = get_the_email_html()
  # Authentification session with .env
  gmail = Gmail.connect(ENV['USERNAME'], ENV['PASSWORD'])
  # Envoi du mail à l'adresse email de l'array de la line rentré dans la fonction
  gmail.deliver do
    # destinataire
    to "#{line[2]}"
    # sujet du mail
    subject "Promo de THP spécialement pour la Mairie de #{line[0]}! CP:#{line[1]}"
    # Contenu du mail
    html_part do
      content_type 'text/html; charset=UTF-8'
      body content
    end
  end
end

# Fonction qui permet de faire fonctionner l'ensemble avec la récupération du fichier des adresses de mairies,
# et un appel de la fonction envoyer mail pour chacune des adresses mail
def perform
  townhalls_list = go_through_all_the_lines('../database/townhalls.csv')
  townhalls_list.each do |line|
    if line[2] == "email"
    else
      send_email_to_line(line)
      print "Email envoyé vers #{line[0]}"
    end
  end
end

perform()
