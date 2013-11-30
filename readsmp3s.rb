require '../playlister_partA/lib/artist.rb'
require '../playlister_partA/lib/song.rb'
require '../playlister_partA/lib/genre.rb'
require 'debugger'
require 'awesome_print'

Dir["./data/*.mp3"].each do |file|
  newfile = file[7..-6].split(" - ")
  newfile[0] = Artist.new(newfile[0]) #create new artist
  song_genre = newfile[1].split(" [")
  song_genre[0] = Song.new(song_genre[0]) #create new song
  song_genre[1] = Genre.new(song_genre[1]) #create new genre
  song_genre[0].genre=(song_genre[1]) #add genre to song
  newfile[0].add_song(song_genre[0]) #add song to artist
end

# p Artist.count
ap Artist.all
# p Genre.all