require "open-uri"
require "nokogiri"
require 'dotenv'

Dotenv.load
session_cookie = ENV['SESSION_COOKIE']
day = 3
url = "https://adventofcode.com/2025/day/#{day}/input"

begin
  html_file = URI.open(
    url,
    "Cookie" => "session=#{session_cookie}",
    "User-Agent" => "Mozilla/5.0 (compatible; Ruby script; AdventOfCode)"
  ).read

  content =  html_file.split("\n")
end

p content

def find_the_biggest_number(bank)
  bank_array = bank.chars.map{_1.to_i}
  biggest_digit = bank_array.max
  position = bank_array.find_index(biggest_digit)
  if position == (bank_array.size - 1)
    next_biggest_digit = bank_array[0..position-1].max
    next_biggest_digit * 10 + biggest_digit
  else
    next_biggest_digit = bank_array[position+1..].max
    biggest_digit * 10 + next_biggest_digit
  end
end

sum = 0

content.each do |bank|
  sum += find_the_biggest_number(bank)
end

puts sum