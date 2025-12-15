require "open-uri"
require "nokogiri"
require 'dotenv'
require 'matrix'

Dotenv.load
session_cookie = ENV['SESSION_COOKIE']
day = 8
url = "https://adventofcode.com/2025/day/#{day}/input"

begin
  html_file = URI.open(
    url,
    "Cookie" => "session=#{session_cookie}",
    "User-Agent" => "Mozilla/5.0 (compatible; Ruby script; AdventOfCode)"
  ).read

  content =  html_file.split("\n")
end

points = content.map do |line|
  x,y,z = line.split(",")
  [x.to_i,y.to_i,z.to_i]
end

def distance(pos1, pos2)
  (Vector[*pos1] - Vector[*pos2]).magnitude.round(2)
end


min = {}
points.each do |pos1|
  distance = [nil, Float::INFINITY]
  points.each do |pos2|
    next if pos1 == pos2
    dis = distance(pos1, pos2)
    distance = [pos2, dis] if dis < distance.last
  end
  min[pos1] = distance
end
min = min.sort_by{ |k,v| v.last}

longest = min.last
p longest.first[0] * longest.last[0][0]
