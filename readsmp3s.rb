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

# ap Artist.count
# ap Artist.all
# ap Genre.all

# Genre.all.each do |genre|
#   p genre.songs if genre.name == "folk"
# end

# def each_artist
  
# end

def prompt_user
  puts "Hey user, browse by artist or genre (type what you'd like)."
  text = gets.chomp.downcase
  if text == "artist"
    choose_artist
  elsif text == "genre"
    choose_genre
  else
    "Try again! Type artist or genre."
  end
end

def artist
  ap "#{Artist.count} total artists."
  Artist.all.each do |artist|
    ap "#{artist}, Song count: #{artist.songs_count}." #songs_count isn't working... each artist has a song count of one: rather than one adele having a count of 2, there are 2 adeles with a count of 1
  end
  choose_artist
end

def choose_artist
  ap "Select artist."
  text = gets.chomp.downcase
  Artist.all.each do |artist|
    debugger
    if text == artist.name.downcase
      # songs 
      # artist.songs.each do |song|
      #   p song
      # end
      ap "Songs: #{artist.songs}, Genres: #{artist.genres}" #artist.songs and .genres are arrays
    end
  end
end

def genre
  ap Genre.all
end

choose_artist