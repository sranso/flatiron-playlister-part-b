require './artist.rb'
require './song.rb'
require './genre.rb'
require 'debugger'

class Parser
  def initialize
    Dir["../data/*.mp3"].each do |file|
      new_file = file[8..-6].split(" - ")
      artist_array = Artist.all.select {|artist| artist.name == new_file[0]}
      if artist_array.size == 0
        new_artist = Artist.new(new_file[0])
      else
        new_artist = artist_array[0]
      end
      song_genre = new_file[1].split(" [")
      new_song = Song.new(song_genre[0], new_artist.name) #create new song
      genre_array = Genre.all.select {|genre| genre.name == song_genre[1].capitalize}
      if genre_array.size == 0
        new_genre = Genre.new(song_genre[1]) #set new_genre eq to existing genre
      else
        new_genre = genre_array[0] #create new genre
      end
      new_song.genre=(new_genre) #add genre to song
      new_artist.add_song(new_song) #add song to artist
    end
  end
end