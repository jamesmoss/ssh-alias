#!/usr/bin/env ruby

require 'fileutils'

config_path = File.expand_path('~/.ssh/config')
key_path = File.expand_path('~/.ssh/id_rsa.pub')

FileUtils.touch(config_path)

unless File.exist?(key_path)
  puts 'No private/public key pair found, generating new ones.';
  system 'ssh-keygen -t rsa -q -f ~/.ssh/id_rsa.pub'
end

print "Shortname for the site (e.g myserver): "
shortname = gets.strip;

exit if shortname.empty?

if File.exist?(config_path) and File.read(config_path).include?('host '+shortname+"\n")
  puts "Shortname already exists. Try `ssh #{shortname}`."
  exit;
end

print "Hostname of the server: "
hostname = gets.strip;

exit if hostname.empty?

print "Port (default: 22): "
port = gets.strip;
port = '22' if port.empty?

print "User (default: root): "
user = gets.strip;
user = 'root' if user.empty?

File.open(config_path, 'a') do |file|
  file.puts "host #{shortname}"
  file.puts " hostname #{hostname}"
  file.puts " port #{port}"
  file.puts " user #{user}"
  file.puts ""
end

system "KEY=$(cat #{key_path}); ssh #{shortname} -p #{port} \"mkdir -p ~/.ssh; echo $KEY >> ~/.ssh/authorized_keys;\""

puts "All done! Just type `ssh #{shortname}` to connect to the server from now on."