require 'bundler/setup'
require 'nokogiri'
require 'open-uri'

$BASE_URL = 'https://atom.io/themes/list?direction=desc'

page = Nokogiri::HTML open $BASE_URL
puts page.class