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

# content = File.read("lib/2025/test.txt").split("\n")
now = Time.now
# 1. turn each line into manipulatable array so it is easy to calculate their distance
points = content.map do |line|
  x,y,z = line.split(",")
  [x.to_i,y.to_i,z.to_i]
end

def distance(pos1, pos2)
  (Vector[*pos1] - Vector[*pos2]).magnitude.round(2)
end

# 2. get distances of any two points and sort them by their distance from closest to furthest

distance = {}

points.each_with_index do |pos1, idx1|
  points.each_with_index do |pos2, inx2|
    next if pos2 == pos1
    dis = distance(pos1, pos2)
    distance[dis] ||= []
    distance[dis] << [pos1, pos2].sort
  end
end
distance.each {|k,v| distance[k] = v.uniq }
distances_in_order = distance.sort_by {|k,v| k}.to_h.values.map { _1[0]}

# 3. connect boxes from the pairs with the shortest distance
operations = 1000
distances_in_order = distances_in_order.first(operations)

connections = []
distances_in_order.each do |pos1, pos2|
  circuit = connections.find do |circuit|
    circuit.include?(pos1) || circuit.include?(pos2)
  end || []
  index_to_be_replaced = connections.index{ _1 == circuit} unless circuit.empty?
  circuit << pos1
  circuit << pos2
  circuit.uniq!
  if index_to_be_replaced
    connections[index_to_be_replaced] = circuit
  else
    connections << circuit
  end
end

# 4. check if there are any circuits that are already in the same circuit. They should be combined into 1 circuit
all_coordiantes = connections.flatten(1)
duplicates = all_coordiantes.select { |e| all_coordiantes.count(e) > 1 }.uniq
duplicates.each do |coordinate|
  # find all the sub circuits with duplicated coordinates
  circuits =connections.select do |circuit|
    circuit.include?(coordinate)
  end
  # delete those sub circuits
  connections.reject! do |circuit|
    circuit.include?(coordinate)
  end
  # append sub circuits and this big circuit is the final circuit
  big = circuits.flatten(1).uniq
  connections << big
end

# 5. sort the connection by its size and find the top 3 with size
wires = connections.sort_by {_1.count}.reverse

m = 1
wires.first(3).each do |circuit|
  m *= circuit.size
end

p m
puts "Time taken: #{Time.now - now} seconds"