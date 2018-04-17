require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'pry'
require 'csv'

def get_all_the_urls_of_townhalls(pages)
  links_list = []
  pages.each do |page_number|
    page = Nokogiri::HTML(open("http://annuaire-des-mairies.com/#{page_number}"))
    table_links = page.css("a.lientxt")
    table_links.each do |link|
      links_list << "#{link['href'].sub(/./, "http://annuaire-des-mairies.com")}"
    end
  end
  return links_list
end

def get_number_of_pages(dept)
  dept_pages = Nokogiri::HTML(open("http://annuaire-des-mairies.com/#{dept}.html"))
  pages = []
  page_links = dept_pages.css("center p a")
  page_links.each do |link|
  pages << "#{link["href"]}"
  end
  return pages
end

def get_the_email_of_a_townhall_from_its_webpage(url)
  townhall_hash = {}
  url.each do |url|
    page = Nokogiri::HTML(open(url))
    name = page.css("/html/body/div/main/section[1]/div/div/div/h1").text.gsub(" - ","").gsub!(/[0-9]/, "")
    zipcode = url.gsub!(/\D/, "")
    email = page.css("/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]").text
    townhall_hash = { :name => name, :zipcode => zipcode, :email => email }
  end
   return townhall_hash
end


def perform(dept)
  # get_the_email_of_a_townhall_from_its_webpage(get_number_of_pages(dept))
  get_the_email_of_a_townhall_from_its_webpage(get_all_the_urls_of_townhalls(get_number_of_pages(dept)))
end

 p perform("gironde")
