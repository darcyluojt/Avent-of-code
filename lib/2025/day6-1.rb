require "open-uri"
require "nokogiri"
require 'dotenv'

Dotenv.load
session_cookie = ENV['SESSION_COOKIE']
day = 6
url = "https://adventofcode.com/2025/day/#{day}/input"

begin
  html_file = URI.open(
    url,
    "Cookie" => "session=#{session_cookie}",
    "User-Agent" => "Mozilla/5.0 (compatible; Ruby script; AdventOfCode)"
  ).read

  content =  html_file.split("\n")
end

# content = "123 328  51 64
#  45 64  387 23
#   6 98  215 314
# *   +   *   +  ".split("\n")

processed = []
operators = content.last.split(" ").delete_if{ _1 == " " }
content[..content.size-2].each do |line|
  processed << line.split(" ").map { _1.to_i }.delete_if{ _1==0 }
end

all = 0
operators.each_with_index do |operator, index|
  numbers = processed.map {_1[index]}
  if operator == "+"
    all += numbers.sum
  else
    all += numbers.reduce(:*)
  end
end

puts all