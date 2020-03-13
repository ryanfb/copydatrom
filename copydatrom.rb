#!/usr/bin/env ruby
require 'digest/sha1'
require 'nokogiri'
require 'find'
require 'fileutils'

if ARGV.length != 3
  $stderr.puts "Usage: bundle exec ./copydatrom.rb datfile.dat source-rom-dir target-rom-dir"
  exit 1
end

dat_filename, source_rom_dir, target_rom_dir = ARGV
$stderr.puts "Parsing #{dat_filename}..."
dat_doc = Nokogiri::XML(File.open(dat_filename))

$stderr.puts "Checking #{target_rom_dir}..."
FileUtils.mkdir_p(target_rom_dir)

$stderr.puts "Scanning #{source_rom_dir} for files..."
Find.find(source_rom_dir) do |f|
  if FileTest.file? f
    $stderr.puts "Checking: #{f}"
    sha1 = Digest::SHA1.hexdigest(File.read(f)).upcase
    $stderr.puts "SHA1: #{sha1}"
    matching_rom = dat_doc.xpath("//rom[@sha1='#{sha1}']").first
    matching_rom ||= dat_doc.xpath("//rom[@sha1='#{sha1.downcase}']").first
    if matching_rom
      FileUtils.cp(f, File.join(target_rom_dir, matching_rom['name']), :verbose => true)
    else
      $stderr.puts "No match found!"
    end
    $stderr.puts
  end
end
