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



def find_the_biggest_number(bank, digits)
  bank_array = bank.chars.map{_1.to_i}
  biggest_numbers = []
  max_position = -1
  digits.times do |i|
    start_position = max_position + 1
    end_postion = bank.size - 1 - (digits - i - 1)
    max = bank_array[start_position..end_postion].max
    max_position = bank_array[start_position..end_postion].find_index(max) + start_position
    biggest_numbers << max
  end
  biggest_numbers.join.to_i
end

sum = 0

content.each do |bank|
  sum += find_the_biggest_number(bank,12)
end

puts sum