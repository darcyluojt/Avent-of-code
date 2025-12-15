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

  content =  html_file
end
p content

# content = File.read("lib/2025/test.txt").split("\n")

# total_press = 0
# content.each_with_index do |line, on_which_line|

#   # count number of switches
#   switches = line[/\[([^\]]+)\]/, 1].chars.count
#   ## switches = 4
#   # organise buttons in an array of button series (in an array)
#   buttons_str = line.split("]").last.split("{").first
#   buttons = buttons_str.scan(/\(([^)]+)\)/).map { |match| match[0].split(",").map(&:to_i) }
#   num_variables = buttons.count
#   # number of variables
#   ## buttons [[3], [1, 3], [2], [2, 3], [0, 2], [0, 1]]
#   # manipulate joltage into position - pressed times key-value pairs. For ease of comarison, button
#   # with 0 press will still be in the joltage hash as joltage[button] = 0
#   joltage = line[/{([^}]+)}/, 1].split(",").map { _1.to_i }
#   ## jotalge {0=>3, 1=>5, 2=>4, 3=>7}
#   coefficient_matrix = Array.new(switches)
#   joltage.each_with_index do |equation_value, i|
#     array = []
#     buttons.each_with_index do |button|
#       v = button.include?(i) ? 1:0
#       array << v
#     end
#     coefficient_matrix[i] = array
#   end
#   a_matrix = Matrix[*coefficient_matrix]
#   b_vector = Matrix.column_vector(joltage)
#   begin
#     solution = a_matrix.lup_decomposition.solve(b_vector)
#     x = solution.to_a.flatten
#     puts "Exact solution found: #{x.sum}"
#     total_press += x.sum
#   rescue Matrix::ErrNotRegular
#     puts "No unique solution - falling back to approximation"
#   # Fall back to your existing brute force or use approximation
#     puts "#{joltage}: #{buttons}"
#   end
# end

# # p total_press
# # p left_over