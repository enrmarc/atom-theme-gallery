require 'bundler/setup'

require 'json'
require 'erb'
require 'ostruct'

themes = JSON.parse File.read 'output.json'

bb = binding
bb.local_variable_set(:themes, themes)

template = ERB.new(File.new('index.html.erb').read, nil, '%')
puts template.result bb