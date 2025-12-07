require "open-uri"
require "nokogiri"
require 'dotenv'

Dotenv.load
session_cookie = ENV['SESSION_COOKIE']
day = 7
url = "https://adventofcode.com/2025/day/#{day}/input"

begin
  html_file = URI.open(
    url,
    "Cookie" => "session=#{session_cookie}",
    "User-Agent" => "Mozilla/5.0 (compatible; Ruby script; AdventOfCode)"
  ).read

  content =  html_file.split("\n")
end


content = content.map { _1.chars }


columns = content.first.size

start = {[0, content.first.index("S")] => 1}
puts "total row #{content.count}"

content.each_with_index do |line, row|
  # exit if it is the last line
  next if row == content.count - 1

  new_start = {}
  start.keys.each do |point|
    column = point[1]
    if content[row+1][column] == "^"
      if column-1 >= 0
        pos = [row+1, column-1]
        new_start[pos] ||= 0
        new_start[pos] += start[point]
      end
      if column+1 < columns
        pos = [row+1, column+1]
        new_start[pos] ||= 0
        new_start[pos] += start[point]
      end
    else
      pos = [row+1, column]
      new_start[pos] ||= 0
      new_start[pos] += start[point]
    end
    p "point: #{point}, start: #{start}"
  end
  start = new_start
end

puts "-----------result--------"
p start
p start.values.sum
