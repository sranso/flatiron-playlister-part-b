require './artist.rb'
require './song.rb'
require './genre.rb'
require './parser.rb'
require 'debugger'

class Playlister

  def initialize
    Parser.new
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
    puts "#{::Artist.count} total artists."
    ::Artist.all.each do |artist|
      puts "#{artist.name}, Song count: #{artist.songs_count}"
    end
    choose_artist
  end

  def more_than_one(text, class_name)
    similar_objects = class_name.all.select{|object| object.name.downcase.include?(text)}
    similar_objects.size > 1 ? similar_objects : nil
  end

  def puts_artist_song_genre(text, class_name)
    num = 0
    class_name.all.select do |object|
      if object.name.downcase.include?(text)
        puts "#{object.name} - #{object.songs_count} Songs" 
        object.songs.each do |song|
          num += 1
          puts "#{num}. #{song.title} - #{song.genre.name}"
        end         
      end
    end
  end

  def choose_artist
    puts "Choose an artist."
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
        puts_artist_song_genre(text, Artist)
      else
        puts_artist_song_genre(text, Artist)
      end
    end
  end

  def genres
    sorted_genres = ::Genre.all.sort_by {|genre| genre.songs.size}
    sorted_genres.reverse.each do |genre|
      puts "#{genre.name}: #{genre.songs.size} Songs, #{genre.artists.size} Artists"
    end
    choose_genre
  end

  def puts_genre_song_artist(text, class_name)
    num = 0
    class_name.all.select do |object|
      if object.name.downcase.include?(text)
        puts "#{object.name} = #{object.songs.size} Songs"
        object.songs.each do |song|
          num += 1
          puts "#{num}. #{song.title} - #{song.artist}"
        end
      end
    end
  end

  def choose_genre
    puts "Choose a genre."
    text = gets.chomp.downcase
    if text == "h" || (text == "help")
      help
    else
      genres = more_than_one(text, Genre)
      if genres
        puts "These are the results that match your query:"
        genres.each {|genre| puts "#{genre.name} - #{genre.songs.size} Songs"}
        puts "Which of these genres would you like to view?"
        text = gets.chomp.downcase
        puts_genre_song_artist(text, Genre)
      else
        puts_genre_song_artist(text, Genre)
      end
    end
  end

  def run
    prompt_user
    want = true
    while want
      last_text = prompt_user
      want = false if last_text == "q"
    end
  end

end

testrun = Playlister.new
testrun.prompt_user

# 1. create get_text method. text = gets.chomp.downcase. text.match(exit?) then exit. else return text
# 2. put all this in a class... duh duh duhnhnn CHECK
# 3. object oriented programming... put methods in appropriate class
