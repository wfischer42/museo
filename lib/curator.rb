require './lib/photograph'
require './lib/artist'

class Curator
  attr_reader :artists,
              :photographs

  def initialize
    @artists = []
    @photographs = []
  end

  def add_photograph(attributes)
    new_photo = Photograph.new(attributes)
    @photographs << new_photo
  end

  def add_artist(attributes)
    new_artist = Artist.new(attributes)
    @artists << new_artist
  end

  def find_artist_by_id(id)
    @artists.find do |artist|
      artist.id == id
    end
  end

  def find_photograph_by_id(id)
    @photographs.find do |photograph|
      photograph.id == id
    end
  end

  def find_photographs_by_artist(artist)
    @photographs.find_all do |photograph|
      photograph.artist_id == artist.id
    end
  end
end
