require "open-uri"
require "nokogiri"
require 'dotenv'

Dotenv.load
session_cookie = ENV['SESSION_COOKIE']
day = 2
url = "https://adventofcode.com/2025/day/#{day}/input"

begin
  html_file = URI.open(
    url,
    "Cookie" => "session=#{session_cookie}",
    "User-Agent" => "Mozilla/5.0 (compatible; Ruby script; AdventOfCode)"
  ).read

  content =  html_file.split("\n")[0].split(",")
end

# content = "11-22,95-115,998-1012,1188511880-1188511890,222220-222224,1698522-1698528,446443-446449,38593856-38593862,565653-565659,824824821-824824827,2121212118-2121212124"
# content = content.split(",")
ranges = []
content.each do |range|
  start_id, end_id = range.split("-")
  if start_id.size == end_id.size
    ranges << [start_id, end_id]
  else
    ranges << [start_id, "9"*start_id.size]
    min = ("1"+("0"*start_id.size))
    ranges << [min, end_id]
  end
end


def number_to_multiply(size)
  base = []
  pairs = []
  for i in (2..size)
    base << i if size % i == 0
  end
  base.each do |e|
    zeros = (size / e) - 1
    repete = e-1
    # next if zeros.zero? || repete.zero?
    combination = "1" + (("0"*zeros) + "1") * repete
    # p [zeros, repete, combination]
    pairs << {digits: e, multiplier: combination.to_i }
  end
  # pairs << {digits: 1, multiplier: 11} if size == 2
  puts pairs
  pairs
end

fairy = 0

ranges.each do |min_str, max_str|
  puts "from #{min_str} to #{max_str}"
  min_num = min_str.to_i
  max_num = max_str.to_i
  range = (min_num..max_num)
  fairy_numbers = []
  min_multipliers = number_to_multiply(min_str.size)
  min_multipliers.each do |hash|
    digits = hash[:digits]
    multiplier = hash[:multiplier]
    base = min_str[0..(digits-2)]
    if !multiplier.to_s.include?("0")
      base = 1
    end
    if base[0..((base.size/2)-1)]==base[base.size/2..]
      base = base[0..((base.size/2)-1)]
    end
    base_num = base.to_i
    puts "base number is #{base}, multiplier is #{multiplier}"
    potential_fairy_number = 0
    while potential_fairy_number <= max_num
      potential_fairy_number = base_num * multiplier
      # next if potential_fairy_number.to_s.size.odd?
      # p [base_num, multiplier, potential_fairy_number, digits]
      if range.include?(potential_fairy_number)
        fairy_numbers << potential_fairy_number
      end
      base_num += 1
    end
  end
  p fairy_numbers
  fairy += fairy_numbers.uniq.sum
  p fairy
end

p fairy