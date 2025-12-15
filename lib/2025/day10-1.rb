require "open-uri"
require "nokogiri"
require 'dotenv'
require 'matrix'

Dotenv.load
session_cookie = ENV['SESSION_COOKIE']
day = 10
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

total_press = 0

content.each do |line|
  light_diagrams = {}
  line[/\[([^\]]+)\]/, 1].chars.each_with_index do |c, i|
    on = c == "#" ? 1:0
    light_diagrams[i] = on
  end
  buttons_str = line.split("]").last.split("{").first
  buttons = buttons_str.scan(/\(([^)]+)\)/).map { |match| match[0].split(",").map(&:to_i) }
  diagram = {}
  switches = light_diagrams.keys.count
  press = 1
  until diagram == light_diagrams
    combinations = buttons.combination(press).to_a
    combinations.each do |combination|
      all_toggles = combination.flatten
      diagram = {}
      for i in (0..switches-1)
        diagram[i] = all_toggles.count(i) % 2
      end
      p [light_diagrams, diagram, press, combination]
      break if diagram == light_diagrams
    end
    if diagram == light_diagrams
      total_press += press
    else
      press += 1
    end
    p [light_diagrams, diagram, press, combinations.count]
  end
end

p total_press