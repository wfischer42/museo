require './lib/photograph'

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
end
