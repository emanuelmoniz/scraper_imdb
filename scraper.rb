require 'open-uri'
require 'nokogiri'

PATTERN = /\/\?.*/
BASE_URL = 'http://www.imdb.com'

def fetch_movies_url
  html_doc = Nokogiri::HTML(open('https://www.imdb.com/chart/top').read)
  # p html_doc
  html_doc.search('.titleColumn a').take(5).map do |link|
    BASE_URL + link.attributes['href'].value.gsub(PATTERN, '').to_s
  end
end
# testing
# p fetch_movies_url

PATTERN_TITLE = /(?<title>.*)[[:space]](?<year>\(\d{4}\))/

def scrape_movie(movie_url)
  html_doc = Nokogiri::HTML(open(movie_url).read)

  html_doc.at('.title_wrapper h1').text.strip.match(PATTERN_TITLE)
end
