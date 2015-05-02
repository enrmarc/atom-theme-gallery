require 'bundler/setup'

require 'nokogiri'
require 'open-uri'
require 'json'

ATOM_URL = 'https://atom.io'

themes = []

doc = Nokogiri::HTML open "#{ATOM_URL}/themes/list?direction=desc"
doc.css('.package-list .grid-cell').each do |node|
   card = node.css('.package-card')

   name = card.css('.card-name a')
   desc = card.css('.card-description')
   link = name[0]['href']
   img = (Nokogiri::HTML open "#{ATOM_URL}#{link}").css('.markdown-body img').first

   themes.push({
      :name => name.text,
      :desc => desc.text,
      :link => link,
      :img  => img['src']
   })
end

puts themes.to_json