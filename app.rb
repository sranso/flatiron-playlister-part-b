require '../playlister_partA/lib/artist.rb'
require '../playlister_partA/lib/song.rb'
require '../playlister_partA/lib/genre.rb'
require 'debugger'

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
  puts "-".rjust(60, "-")
  puts "Commands at your disposal:"
  puts "artist         Shows you all artists"
  puts "<artist name>  Shows you all artist's songs and genres"
  puts "genre          Shows you all genres"
  puts "<genre name>   Shows you all genre's songs and artists"
  puts "h              Takes you here!"
  puts "help           Takes you here!"
  puts "q              Exits the program"
  puts "quit           Exits the program"
  puts "-".rjust(60, "-")
end

# def input
#   input = gets.chomp.downcase
# end

def prompt_user
  puts "Browse by artist or genre (type what you'd like)."
  text = gets.chomp.downcase
  if text == "h" || (text == "help")
    help
  elsif text == "artist"
    artists
  elsif text == "genre"
    genres
  elsif text == "q" || (text == "quit")
    exit
  else
    puts "Type h for help."
  end
  text
end

def artists
  puts "#{Artist.count} total artists."
  Artist.all.each do |artist|
    puts "#{artist.name}, Song count: #{artist.songs_count}" #songs_count isn't working... each artist has a song count of one: rather than one adele having a count of 2, there are 2 adeles with a count of 1
  end
  choose_artist
end

def more_than_one(text, class_name)
  similar_objects = class_name.all.select{|object| object.name.downcase.include?(text)}
  similar_objects.size > 1 ? similar_objects : nil
end

def choose_artist
  puts "Choose an artist."
  num = 0
  text = gets.chomp.downcase
  if text == "h" || (text == "help")
    help
  else
    artists = more_than_one(text, Artist)
    if artists
      puts "These are the results that match your query:"
      artists.each {|artist| puts "#{artist.name} - #{artist.songs_count} Songs"}
      puts "Which of these artists would you like to view?"
      text = gets.chomp.downcase
      Artist.all.select do |artist|
        if artist.name.downcase.include?(text)
          puts "#{artist.name} - #{artist.songs_count} Songs" 
          artist.songs.each do |song|
            num += 1
            puts "#{num}. #{song.title} - #{song.genre.name}"
          end         
        end
      end
    else
      Artist.all.select do |artist|
        if artist.name.downcase == text
          puts "#{artist.name} - #{artist.songs_count} Songs"
          artist.songs.each do |song|
            num += 1
            puts "#{num}. #{song.title} - #{song.genre.name}"
          end
        end
      end
    end
  end
end

def genres #need to sort by top number of songs
  Genre.all.each do |genre| #not unique... there are multipes
    puts "#{genre.name}: #{genre.songs.size} Songs, #{genre.artists.size} Artists"
  end
  choose_genre
end

def choose_genre
  puts "Choose a genre."
  num = 0
  text = gets.chomp.downcase
  if text == "h" || (text == "help")
    help
  elsif
    Genre.all.each do |genre|
      if genre.name.downcase.start_with?(text)
        puts "#{genre.name} - #{genre.songs.size} Songs"
        genre.songs.each do |song|
          num += 1
          puts "#{num}. #{song.title} - #{song.artist}" #song.artist doesn't work...
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

# TO FIX/DO
# 49 artist.name.downcase.include?(text) and 71 genre.name.downcase.include?(text)
# need to fix at some point for cases when more than one artist include text entered
# choose_genre

# create get_input method. input = gets.chomp.downcase. input.match(exit?) then exit. else return input

