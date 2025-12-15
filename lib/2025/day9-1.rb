require "open-uri"
require "nokogiri"
require 'dotenv'
require 'matrix'

Dotenv.load
session_cookie = ENV['SESSION_COOKIE']
day = 9
url = "https://adventofcode.com/2025/day/#{day}/input"

begin
  html_file = URI.open(
    url,
    "Cookie" => "session=#{session_cookie}",
    "User-Agent" => "Mozilla/5.0 (compatible; Ruby script; AdventOfCode)"
  ).read

  content =  html_file.split("\n")
end

# content = File.read("lib/2025/test.txt").split("\n")
content = content.map { |line| line.split(",").map(&:to_i) }

max = 0
content.each do |tile1|
  content.each do |tile2|
    if tile1 == tile2
      next
    end
    area_size = ((tile1[0]-tile2[0]).abs + 1) * ((tile1[1] - tile2[1]).abs + 1)
    max = area_size if area_size > max
  end
end

p max
# max = max.sort_by{ |k,v| v.last}
# # p max
# maxiest = max.last[1]
# p maxiest
