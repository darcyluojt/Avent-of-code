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

ranges = []
content.each do |range|
  start_id, end_id = range.split("-")
  ranges << [start_id, end_id]
end
# ranges.reject!{ |x| x.first.size.odd? && x.last.size.odd?}
fairy =0

def number_to_multiply(size)
  number_of_zero = size - 1
  combination = "1" + "0" * number_of_zero + "1"
  combination.to_i
end
ranges.each do |min, max|
  range_fairy = []
  nums_range = (min.to_i..max.to_i)
  base = min[0..((min.size.to_f / 2).ceil)-1]
  base_num_from_min = base.to_i
  multiply_num_from_min = number_to_multiply(base.size)
  puts "-from #{min} to #{max}-"
  fairy_number = min.to_i
  while fairy_number <= max.to_i
    fairy_number = base_num_from_min * multiply_num_from_min
    p [base_num_from_min, multiply_num_from_min, fairy_number]
    if nums_range.include?(fairy_number)
      range_fairy << fairy_number
    end
    base_num_from_min += 1
    multiply_num_from_min = number_to_multiply(base.size + 1) if base_num_from_min.to_s.size > base.size
  end
  base_max = max[0..((max.size.to_f / 2).ceil)-1]
  multiply_num_from_max = number_to_multiply(base_max.size)
  base_num_from_max = base_max.to_i
  fairy_number = max.to_i
  while fairy_number >= min.to_i
    fairy_number = base_num_from_max * multiply_num_from_max
    p [base_num_from_max, multiply_num_from_max, fairy_number]
    if nums_range.include?(fairy_number)
      range_fairy << fairy_number
      base_num_from_max -= 1
      multiply_num_from_max = number_to_multiply(base_max.size - 1) if base_num_from_max.to_s.size < base_max.size
    else
      break
    end
  end

  p range_fairy.uniq
  fairy += range_fairy.uniq.sum

end

puts fairy
