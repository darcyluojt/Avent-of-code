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


last_row = content.count - 1

start = [[0, content.first.index("S")]]
split = []
puts "total row #{content.count}"

content.each_with_index do |line, row|
  if row == last_row || !line.index("^").nil?
    next
  end
  new_start = []
  start.each do |point|
    column = point[1]
    if content[row+1][column] == "^"
      new_start << [row+1, column-1]
      new_start << [row+1, column+1]
      split << [row+1, column]
    else
      new_start << [row+1, column]
    end
    # p "cell: #{content[row+1][column]}, new_start: #{new_start}"
  end
  start = new_start.delete_if { _1[1] < 0}
  puts "row: #{row}, count: #{start.count}}"
end


p start.count
