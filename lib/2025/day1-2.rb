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



sum = 0
point = 50
content.each_with_index do |rotation, i|
  direction = rotation.start_with?("L") ? -1 : 1
  steps = rotation[1..].to_i
  steps.times do
    point += direction
    case point
    when 100
      point = 0
    when -1
      point = 99
    end
    sum += 1 if point.zero?
  end
end
puts sum
