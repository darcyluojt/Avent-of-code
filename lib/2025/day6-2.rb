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



# content = File.read("lib/2025/test6-2.txt").split("\n")

operators = content.last.split(" ").delete_if{ _1 == " " }
chars = content[..content.size-2].map { _1.chars }
transpose = chars.transpose.map do |line|
  line.map {_1.to_i}
end

p transpose
p transpose.size
hash = {}
i = 0 #reflects on the operator
num_pointer = 0
while i < operators.size
  num = transpose[num_pointer].delete_if { _1 == 0}.join.to_i
  while num != 0 && num_pointer < transpose.size
    puts "num: #{num}, i: #{i}, num_pointer: #{num_pointer}"
    hash[i] ||= []
    hash[i] << num
    num_pointer += 1
    puts "num_pointer: #{num_pointer}, element: #{transpose[num_pointer]}"
    num = transpose[num_pointer].delete_if { _1 == 0}.join.to_i unless num_pointer==transpose.size
  end
  puts "end of operator #{i}, num_pointer: #{num_pointer}"
  num_pointer += 1
  i += 1
end

puts hash

all = 0

operators.each_with_index do |operator, idx|
  numbers = hash[idx]
  if operator == "+"
    all += numbers.sum
  else
    all += numbers.reduce(:*)
  end
end

puts all