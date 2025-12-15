require "open-uri"
require "nokogiri"
require 'dotenv'
require 'matrix'

Dotenv.load
session_cookie = ENV['SESSION_COOKIE']
day = 9
url = "https://adventofcode.com/2025/day/#{day}/input"

begin
  html_file = URI.open(
    url,
    "Cookie" => "session=#{session_cookie}",
    "User-Agent" => "Mozilla/5.0 (compatible; Ruby script; AdventOfCode)"
  ).read

  content =  html_file.split("\n")
end

content = File.read("lib/2025/test.txt").split("\n")
content = content.map { |line| line.split(",").map(&:to_i) }

recetangles = {}
rows = {}
columns = {}
content.each do |tile1|
  content.each do |tile2|
    if tile1 == tile2 || recetangles[[tile2, tile1]]
      next
    end
    area_size = ((tile1[0]-tile2[0]).abs + 1) * ((tile1[1] - tile2[1]).abs + 1)
    recetangles[[tile1, tile2]] = area_size
  end
end

content.each_cons(2) do |tile1, tile2|
  if tile1[0] == tile2[0]
    min, max = [tile1[1], tile2[1]].sort
    columns[tile1[0]] = (min..max)
  else
    min, max = [tile1[0], tile2[0]].sort
    rows[tile1[1]] = (min..max)
  end
end

# last_group = [content[0], content[-1], content[-2]]
# recetangles[last_group] = calculate_size(last_group)

recetangles = recetangles.sort_by { |k,v| v }.reverse
puts "---recetangles--"
p recetangles

puts "Initial columns:"
p columns
puts "------"
rows = rows.sort_by { |k, v| k }.to_h
puts "====== "
puts "Initial rows:"
p rows

columns = columns.sort_by { |k, v| k }.to_h
keys = columns.keys
all_columns = {}
keys.each_cons(2) do |r1, r2|
  for i in (r1...r2)
    all_columns[i] = columns[r1]
  end
end
all_columns[keys.last] = columns[keys.last]

all_columns.each do |key, range|
  rows = range.to_a
  all_rows.each do |row, columns|
    rows << row if columns.include?(key)
  end
  all_columns[key] = rows.uniq.sort
end

p all_columns
# size = 0
recetangles.each do |key, dis|
  pos1, pos2 = key
  pos3 = [pos2[0], pos1[1]]
  pos4 = [pos1[0], pos2[1]]
  if all_columns[pos2[0]]&.include?(pos1[1]) && all_columns[pos1[0]]&.include?(pos2[1])
    puts dis and break
  end
end
