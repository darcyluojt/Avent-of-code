require "open-uri"
require "nokogiri"
require 'dotenv'

Dotenv.load
session_cookie = ENV['SESSION_COOKIE']
day = 4
url = "https://adventofcode.com/2025/day/#{day}/input"

begin
  html_file = URI.open(
    url,
    "Cookie" => "session=#{session_cookie}",
    "User-Agent" => "Mozilla/5.0 (compatible; Ruby script; AdventOfCode)"
  ).read

  content =  html_file.split("\n")
end

# content ="..@@.@@@@.
# @@@.@.@.@@
# @@@@@.@.@@
# @.@@@@..@.
# @@.@@@@.@@
# .@@@@@@@.@
# .@.@.@.@@@
# @.@@@.@@@@
# .@@@@@@@@.
# @.@.@@@.@.".split("\n")

grid = []

content.each do |line|
  grid << line.chars.map! { _1 == "@" ? 1:0}
end


def forkliftable?(row, column, grid, row_range: nil, column_range: nil)
  return false if grid[row][column] == 0
  row_range ||= (0..grid.size-1)
  column_range ||= (0..grid.first.size-1)
  potential_neighbours = [[row-1, column], [row-1, column+1], [row-1, column-1],
                          [row, column-1], [row, column+1],
                          [row+1,column-1], [row+1,column],  [row+1,column+1]]
  neighbours = potential_neighbours.select { row_range.include?(_1) && column_range.include?(_2)}
  sum = 0
  neighbours.each do |row, column|
    sum += grid[row][column]
  end
  sum < 4 ? true : false
end

forklift = []
forklifted = 1

while forklifted != 0
  forklifted = 0
  grid.each_with_index do |row, row_idx|
    row.each_with_index do |cell, col_idx|
      if forkliftable?(row_idx, col_idx, grid)
        forklifted += 1
        grid[row_idx][col_idx] = 0
      end
    end
  end
  forklift << forklifted
  p forklift
end

puts forklift.sum