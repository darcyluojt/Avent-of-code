require "open-uri"
require "nokogiri"
require 'dotenv'

Dotenv.load
session_cookie = ENV['SESSION_COOKIE']
day = 5
url = "https://adventofcode.com/2025/day/#{day}/input"

begin
  html_file = URI.open(
    url,
    "Cookie" => "session=#{session_cookie}",
    "User-Agent" => "Mozilla/5.0 (compatible; Ruby script; AdventOfCode)"
  ).read

  content =  html_file.split("\n")
end


ranges_in_array = []
content.each do |string|
  elements = string.split("-")
  next if elements.empty?
  if elements.count == 2
    ranges_in_array << [elements.first.to_i, elements.last.to_i]
  end
end

ranges_in_array = ranges_in_array.sort_by { _1.first }

i = 0
while i < (ranges_in_array.size-1)
  if ranges_in_array[i].max >= ranges_in_array[i + 1].min
    ranges_in_array[i][-1] = [ranges_in_array[i][-1], ranges_in_array[i + 1][-1]].max
    ranges_in_array.delete_at(i+1)
  else
    i += 1
  end
end

num = 0
ranges_in_array.each do |min, max|
  num += (max - min + 1)
end
p num