require 'bundler/setup'

require 'nokogiri'
require 'open-uri'
require 'json'

ATOM_URL = 'https://atom.io'
PAGES    = 20
themes   = []

1.upto(PAGES) do |page|
   doc = Nokogiri::HTML open "#{ATOM_URL}/themes/list?direction=desc&page=#{page}"
   i = 0
   doc.css('.package-list .grid-cell').each do |node|
      STDERR.puts "page: #{page}, theme #{i}"
      card = node.css('.package-card')

      name = card.css('.card-name a')
      desc = card.css('.card-description')
      link = name[0]['href']
      img = (Nokogiri::HTML open "#{ATOM_URL}#{link}").css('.markdown-body img').first

      themes.push({
         :name => name.text,
         :desc => desc.text,
         :link => link,
         :img  => img && img['src']
      })
      i += 1
   end
end

puts themes.to_json