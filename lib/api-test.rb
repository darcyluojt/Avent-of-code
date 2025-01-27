require "open-uri"
require "nokogiri"

day = 6
url = "https://adventofcode.com/2024/day/#{day}/input"


begin
  html_file = URI.open(
    url,
    "Cookie" => "session=#{session_cookie}",
    "User-Agent" => "Mozilla/5.0 (compatible; Ruby script; AdventOfCode)"
  ).read

  # Parse the HTML document
  html_doc = Nokogiri::HTML.parse(html_file)
  content = html_doc.text
  p content
end
