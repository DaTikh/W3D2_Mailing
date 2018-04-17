require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'pry'
require 'csv'

  # On définit dans un tableau les liens vers la page de chaque mairie.
def get_all_the_urls_of_townhalls(pages)
  puts "Acquisition des liens vers chaque mairie..."
  links_list = []
  pages.each do |page_number| # On boucle sur chacune des pages du département en cours.
    page = Nokogiri::HTML(open("http://annuaire-des-mairies.com/#{page_number}"))
    table_links = page.css("a.lientxt")
    table_links.each do |link|
      links_list << "#{link['href'].sub(/./, "http://annuaire-des-mairies.com")}" # Pour chaque page on récupère les liens dans un tableau.
    end
  end
  puts "Le département contient #{links_list.size} mairies."
  return links_list
end

  # On recherche le nombre de pages à scrapper par département passé en paramètre.
def get_number_of_pages(dept)
  puts "Acquisition du nombre de pages sur le menu..."
  dept_pages = Nokogiri::HTML(open("http://annuaire-des-mairies.com/#{dept}.html")) # On ouvre la page d'un département passé en paramètre.
  pages = []
  page_links = dept_pages.css("center p a")
  page_links.each do |link|
  pages << "#{link["href"]}"
  end
  puts "Le menu contient #{pages.size} pages."
  return pages
end

  # On ouvre le lien correspondant à chaque mairie pour récupérer son nom, code postal et email.
def get_the_email_of_a_townhall_from_its_webpage(url)
  puts "Acquisition de la liste d'emails..."
  townhall_hash = {}
  final_array = []
  url.each do |url|
    begin
    page = Nokogiri::HTML(open(url))
    name = page.css("/html/body/div/main/section[1]/div/div/div/h1").text.gsub(" - ","").gsub!(/[0-9]/, "") # On enlève le tiret et les chiffres du titre.
    zipcode = url.gsub!(/\D/, "") # On récupère uniquement les chiffres de l'url.
    email = page.css("/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]").text # On sélectionne l'email.
    townhall_hash = { :name => name, :zipcode => zipcode, :email => email } # Les infos de chaque mairie.
    print townhall_hash
    final_array << townhall_hash
  rescue OpenURI::HTTPError => ex # En cas d'erreur 404, on préfère skip complètement la mairie.
    end
  end
  puts "#{final_array.size} adresses email obtenues."
  return final_array
end

  # On crée finalement la db.
def to_csv(final_array)
  final_array = final_array.flatten! # Mise en forme de notre tableau final, il contient les infos des 3 départements.
  puts "Inscription du listing dans la base de données..."
  CSV.open("../database/townhalls.csv", "wb") do |csv| # On ouvre/crée la db en écriture.
    csv << final_array.first.keys # On rentre les clés de nos hash en première ligne (name, zipcode, email).
    final_array.each do |x|
    csv << x.values # Chaque ligne est composée des valeurs du hash correpsondant aux infos de la mairie.
    end
    end
  puts "Base de données mise à jour !!"
end

  # Perform du scrapper : on rentre en paramètre un tableau avec 3 départements, et on appelle les méthodes en cascade.
def perform_scrapper(dept)
  final_array = []
  dept.each do |dept|
  puts "Début de l'acquisition des données pour #{dept.capitalize}..."
  final_array << get_the_email_of_a_townhall_from_its_webpage(get_all_the_urls_of_townhalls(get_number_of_pages(dept)))
  puts "Acquisition des données pour #{dept.capitalize} terminée !!"
  end
  to_csv(final_array)
end
