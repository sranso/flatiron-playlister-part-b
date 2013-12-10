class Artist
  attr_accessor :name, :songs, :genres, :count

  ARTISTS = []

  def initialize(name)
    @name = name
    @songs = []
    @genres = []
    ARTISTS << self
  end

  def self.reset_artists
    ARTISTS.clear
  end

  def self.count
    ARTISTS.size
  end

  def self.all
    ARTISTS
  end

  def songs_count
    songs.size
  end

  def add_song(song)
    songs << song
    genres << song.genre
    if song.genre && ((song.genre.artists.include? self) == false)
      song.genre.artists << self 
    end
  end
  
end
