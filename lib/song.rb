class Song
  attr_accessor :title, :artist
  attr_reader :genre

  def initialize(title, artist)
    @title = title
    @genre
    @artist = artist
  end

  def genre=(genre_obj)
    @genre = genre_obj
    genre_obj.songs << self unless genre_obj.songs.include? self
  end

end

