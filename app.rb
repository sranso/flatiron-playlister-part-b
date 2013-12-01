require '../playlister_partA/lib/artist.rb'
require '../playlister_partA/lib/song.rb'
require '../playlister_partA/lib/genre.rb'
require 'debugger'
require 'awesome_print'

Dir["./data/*.mp3"].each do |file|
  new_file = file[7..-6].split(" - ")
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

def help
  ap "Commands at your disposal:"
  ap "artist         Shows you all artists"
  ap "<artist name>  Shows you all artist's songs and genres"
  ap "genre          Shows you all genres"
  ap "<genre name>   Shows you all genre's songs and artists"
  ap "h              Takes you here!"
  ap "help           Takes you here!"
  ap "q              Exits the program"
  ap "quit           Exits the program"
end

def prompt_user
  ap "Browse by artist or genre (type what you'd like)."
  text = gets.chomp.downcase
  if text == "h" || (text == "help")
    help
  elsif text == "artist"
    artists
  elsif text == "genre"
    genres
  elsif text == "q" || (text == "quit")
    text
  else
    ap "Try again! Type artist or genre."
  end
  text
end

def artists
  ap "#{Artist.count} total artists."
  Artist.all.each do |artist|
    ap "#{artist.name}, Song count: #{artist.songs_count}." #songs_count isn't working... each artist has a song count of one: rather than one adele having a count of 2, there are 2 adeles with a count of 1
  end
  choose_artist
end

def choose_artist
  ap "Choose an artist."
  num = 0
  text = gets.chomp.downcase
  if text == "h" || (text == "help")
    help
  else Artist.all.each do |artist|
    if artist.name.downcase.include?(text) #need to fix at some point for cases when more than one artist include text entered
      ap "#{artist.name} - #{artist.songs_count} Songs"
      artist.songs.each do |song|
        num += 1
        ap "#{num}. #{song.title} - #{song.genre.name}"
      end
    end
  end
  end
end

def genres #need to sort by top number of songs
  Genre.all.each do |genre| #not unique... there are multipes
    ap "#{genre.name}: #{genre.songs.size} Songs, #{genre.artists.size} Artists"
  end
  choose_genre
end

def choose_genre
  ap "Choose a genre."
  num = 0
  text = gets.chomp.downcase
  if text == "h" || (text == "help")
    help
  else Genre.all.each do |genre|
    if genre.name.downcase.include?(text) #need to fix at some point for cases when more than one artist include text entered
      ap "#{genre.name} - #{genre.songs.size} Songs"
      genre.songs.each do |song|
        num += 1
        ap "#{num}. #{song.title} - #{song.artist}" #song.artist doesn't work...
      end
    end
  end
  end
end

prompt_user
want = true
while want
  last_input = prompt_user
  want = false if last_input == "q"
end

# TO FIX
# 2. 49 artist.name.downcase.include?(text) and 71 genre.name.downcase.include?(text)
# need to fix at some point for cases when more than one artist include text entered
