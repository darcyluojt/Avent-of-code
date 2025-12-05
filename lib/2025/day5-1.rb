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

puts content

ranges =[]
min = []
ingredients = []
content.each do |string|
  elements = string.split("-")
  next if elements.empty?
  if elements.count == 1
    ingredients << elements.first.to_i
  else
    ranges << (elements.first.to_i..elements.last.to_i)
    min << elements.first.to_i
  end
end

fresh = []

ingredients.each do |id|
  potential_ranges_index = []
  min.each_with_index do |num, idx|
    if num <= id
      potential_ranges_index << idx
    end
  end
  next if potential_ranges_index.empty?
  potential_ranges_index.each do |idx|
    range = ranges[idx]
    if range.include?(id)
      fresh << id
      break
    end
  end
end

puts fresh.uniq.count
