require 'bundler/setup'

require 'nokogiri'
require 'open-uri'
require 'json'

ATOM_URL = 'https://atom.io'
PAGES    = 100
SKIPPED_IMGS = ['img.shields.io', 'pledgie.com', 'travis-ci.org', 'badge.waffle.io']
themes   = []

1.upto(PAGES) do |page|
   doc = Nokogiri::HTML open "#{ATOM_URL}/themes/list?direction=desc&page=#{page}"
   i = 0
   doc.css('.package-list .grid-cell').each do |node|
      STDERR.puts "page: #{page}, theme #{i}"
      card = node.css('.package-card')

      name = card.css('.card-name a')
      desc = card.css('.card-description')
      author = card.css('.author')
      link = name[0]['href']
      imgs = (Nokogiri::HTML open "#{ATOM_URL}#{link}").css('.markdown-body img')
      screenshot = imgs.select { |n|
          !SKIPPED_IMGS.any? { |skip| n['data-canonical-src']&.include? skip }
      }.first

      themes.push({
         :name => name.text.strip.capitalize,
         :desc => desc.text.strip,
         :author => author.text.strip,
         :link => link,
         :img  => screenshot && screenshot['src']
      })
      i += 1
   end
end

puts themes.to_json
