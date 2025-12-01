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
puts content.class
def rotated_value(starting_point, rotations)
  direction = rotations.start_with?("L") ? -1 : 1
  processed_rotations = direction * rotations[1..].to_i
  point = starting_point + processed_rotations
  processed_point = if (0..99).include?(point)
    point
  elsif point.negative?
    (point + 100) % 100
  else
    (point-100) % 100
  end
  processed_point
end

sum = 0
start = 50
content.each_with_index do |rotation, i|
  start = rotated_value(start, rotation)
  sum += 1 if start.zero?
end
puts sum
