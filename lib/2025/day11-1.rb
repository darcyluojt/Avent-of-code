require "open-uri"
require "nokogiri"
require 'dotenv'
require 'matrix'

Dotenv.load
session_cookie = ENV['SESSION_COOKIE']
day = 11
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

engine = {}
content.each do |line|
  key = line.split(":").first
  # p lines.split(":").last
  values = line.split(":").last.split(" ").delete_if { _1 == " " }
  engine[key] = values
end


def count_paths(engine, start, seen=[])
  # puts "start: #{start}, output: #{engine[start]}, seen: #{seen}"
  return 1 if start == "out"
  return 0 if seen.include?(start)
  count = 0
  currently_seen = seen + [start]
  engine[start].each do |next_node|
    # puts "inside iteration - next node: #{next_node}, currently_seen: #{currently_seen}"
    count += count_paths(engine, next_node, currently_seen)
  end
  count
end

p count_paths(engine, "you")