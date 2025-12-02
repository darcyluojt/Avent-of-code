require "open-uri"
require "nokogiri"
require 'dotenv'

Dotenv.load
session_cookie = ENV['SESSION_COOKIE']
day = 1
url = "https://adventofcode.com/2025/day/#{day}/input"

begin
  html_file = URI.open(
    url,
    "Cookie" => "session=#{session_cookie}",
    "User-Agent" => "Mozilla/5.0 (compatible; Ruby script; AdventOfCode)"
  ).read

  content =  html_file.split("\n")
end



zeros = 0
point = 50

content.each do |rotation|
  direction = rotation.start_with?("L") ? -1 : 1
  steps = rotation[1..].to_i
  steps.times do
    point += direction
    point %= 100
    zeros += 1 if point.zero?
  end
end
puts zeros
