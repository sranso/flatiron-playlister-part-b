require '../playlister_partA/lib/artist.rb'
require '../playlister_partA/lib/song.rb'
require '../playlister_partA/lib/genre.rb'
require 'debugger'
require 'awesome_print'

Dir["./data/*.mp3"].each do |file|
  newfile = file[7..-6].split(" - ")
  newfile[0] = Artist.new(newfile[0]) unless Artist.all.include?(newfile[0])
  # debugger
  # puts "hi"
  # newfile[0] = Artist.new(newfile[0])
  song_genre = newfile[1].split(" [")
  song_genre[0] = Song.new(song_genre[0]) #create new song
  song_genre[1] = Genre.new(song_genre[1]) #create new genre
  song_genre[0].genre=(song_genre[1]) #add genre to song
  newfile[0].add_song(song_genre[0]) #add song to artist
end
# TO FIX
# 1. 39 artist.songs_count isn't working... each artist has a song count of 1: 
# rather than one adele having a count of 2, there are 2 adeles with a count of 1
# 2. 49 artist.name.downcase.include?(text) and 71 genre.name.downcase.include?(text)
# need to fix at some point for cases when more than one artist include text entered
# 3. 60 Genre.all isn't working.. there are multipes
# 4. 75 song.artist
# 5. create new artist and genre only it that doesn't already exist

def prompt_user
  ap "Hey user, browse by artist or genre (type what you'd like)."
  text = gets.chomp.downcase
  if text == "artist"
    artists
  elsif text == "genre"
    genres
  else
    ap "Try again! Type artist or genre."
  end
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
  Artist.all.each do |artist|
    if artist.name.downcase.include?(text) #need to fix at some point for cases when more than one artist include text entered
      ap "#{artist.name} - #{artist.songs_count} Songs"
      artist.songs.each do |song|
        num += 1
        ap "#{num}. #{song.title} - #{song.genre.name}"
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
  Genre.all.each do |genre|
    if genre.name.downcase.include?(text) #need to fix at some point for cases when more than one artist include text entered
      ap "#{genre.name} - #{genre.songs.size} Songs"
      genre.songs.each do |song|
        num += 1
        ap "#{num}. #{song.title} - #{song.artist}" #song.artist doesn't work...
      end
    end
  end
end

# 1
ap "#{Artist.count} total artists."
Artist.all.each do |artist|
  ap "#{artist.name}, Song count: #{artist.songs_count}." #songs_count isn't working... each artist has a song count of one: rather than one adele having a count of 2, there are 2 adeles with a count of 1
end



