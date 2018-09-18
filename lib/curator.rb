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
end
