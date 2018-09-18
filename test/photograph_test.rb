require_relative 'test_helper'
require './lib/photograph'

class PhotographTest < Minitest::Test
  def setup
    photo_attributes = {
      id: "1",
      name: "Rue Mouffetard, Paris (Boy with Bottles)",
      artist_id: "4",
      year: "1954"
    }
    @photograph = Photograph.new(photo_attributes)
  end

  def test_it_exists_with_properties
    assert_instance_of Photograph, @photograph
    assert_equal "1", @photograph.id
    assert_equal "Rue Mouffetard, Paris (Boy with Bottles)", @photograph.name
    assert_equal "4", @photograph.artist_id
    assert_equal "1954", @photograph.year
  end

  def test_it

  end
end
