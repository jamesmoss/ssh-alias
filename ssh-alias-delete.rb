#!/usr/bin/env ruby

require 'fileutils'

config_path = File.expand_path('~/.ssh/config')

FileUtils.touch(config_path)

print "Alias to delete (e.g myserver): "
shortname = gets.strip;

exit if shortname.empty?

unless File.read(config_path).include?('host '+shortname+"\n")
  puts 'Alias not found.'
  exit;
end

File.open(config_path, 'r+') do |file|
  pattern = Regexp.escape(shortname)
  file.puts file.read.gsub(/^host #{pattern}\n( .+?\n)+\n/i, '')
end

puts "Alias `#{shortname}` removed."