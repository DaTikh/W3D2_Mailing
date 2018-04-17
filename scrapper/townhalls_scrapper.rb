require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'pry'
require 'csv'

def get_all_the_urls_of_townhalls(pages)
  puts "Acquisition des liens vers chaque mairie..."
  links_list = []
  pages.each do |page_number|
    page = Nokogiri::HTML(open("http://annuaire-des-mairies.com/#{page_number}"))
    table_links = page.css("a.lientxt")
    table_links.each do |link|
      links_list << "#{link['href'].sub(/./, "http://annuaire-des-mairies.com")}"
    end
  end
  puts "Le département contient #{links_list.size} mairies."
  return links_list
end

def get_number_of_pages(dept)
  puts "Acquisition du nombre de pages sur le menu..."
  dept_pages = Nokogiri::HTML(open("http://annuaire-des-mairies.com/#{dept}.html"))
  pages = []
  page_links = dept_pages.css("center p a")
  page_links.each do |link|
  pages << "#{link["href"]}"
  end
  puts "Le menu contient #{pages.size} pages."
  return pages
end

def get_the_email_of_a_townhall_from_its_webpage(url)
  puts "Acquisition de la liste d'emails..."
  townhall_hash = {}
  final_array = []
  url.each do |url|
    begin
    page = Nokogiri::HTML(open(url))
    name = page.css("/html/body/div/main/section[1]/div/div/div/h1").text.gsub(" - ","").gsub!(/[0-9]/, "")
    zipcode = url.gsub!(/\D/, "")
    email = page.css("/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]").text
    townhall_hash = { :name => name, :zipcode => zipcode, :email => email }
    print townhall_hash
    final_array << townhall_hash
  rescue OpenURI::HTTPError => ex
    end
  end
  puts "#{final_array.size} adresses email obtenues."
  return final_array
end

def to_csv(final_array)
  final_array = final_array.flatten!
  puts "Inscription du listing dans la base de données..."
  CSV.open("../database/townhalls.csv", "wb") do |csv|
    csv << final_array.first.keys
    final_array.each do |x|
    csv << x.values
    end
    end
  puts "Base de données mise à jour !!"
end

def perform_scrapper(dept)
  final_array = []
  dept.each do |dept|
  puts "Début de l'acquisition des données pour #{dept.capitalize}..."
  final_array << get_the_email_of_a_townhall_from_its_webpage(get_all_the_urls_of_townhalls(get_number_of_pages(dept)))
  puts "Acquisition des données pour #{dept.capitalize} terminée !!"
  end
  to_csv(final_array)
end
