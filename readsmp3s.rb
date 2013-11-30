require '../playlister_partA/lib/artist.rb'
require '../playlister_partA/lib/song.rb'
require '../playlister_partA/lib/genre.rb'
require 'debugger'

Dir["./data/*.mp3"].each do |file|
  newfile = file[7..-6].split(" - ")
  newfile[0] = Artist.new
  song_genre = newfile[1].split(" [")
  song_genre[0] = Song.new
  song_genre[1] = Genre.new
end