#!/usr/bin/env ruby
require 'appscript'
require 'imdb'

thl = Appscript.app("The Hit List")
movies_group = thl.folders_group.groups["Various"].groups["Movies"].get
genres = movies_group.tasks.get

for genre in genres
  for movie in genre.tasks.get
    # No need to get imdb urls for movies that have a url ("note") already
    next unless movie.notes.get.empty?
    
    title = movie.title.get
    imdb_url = Imdb::Search.new(title).movies[0].url
    puts "#{title} - #{imdb_url}"
    movie.notes.set(imdb_url)
  end
end
