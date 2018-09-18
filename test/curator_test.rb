require_relative 'test_helper'
require './lib/curator'

class CuratorTest < Minitest::Test
  def setup
    @curator = Curator.new
    setup_photos
    setup_artists
  end

  def setup_photos
    @photo_1_attrs = {
      id: "1",
      name: "Rue Mouffetard, Paris (Boy with Bottles)",
      artist_id: "1",
      year: "1954"
    }
    @photo_2_attrs = {
      id: "2",
      name: "Moonrise, Hernandez",
      artist_id: "2",
      year: "1941"
    }

    @photo_1 = Photograph.new(@photo_1_attrs)
    @photo_2 = Photograph.new(@photo_2_attrs)
  end

  def setup_artists
    @artist_1_attrs = {
      id: "1",
      name: "Henri Cartier-Bresson",
      born: "1908",
      died: "2004",
      country: "France"
    }
    @artist_2_attrs = {
      id: "2",
      name: "Ansel Adams",
      born: "1902",
      died: "1984",
      country: "United States"
    }

    @artist_1 = Artist.new(@artist_1_attrs)
    @artist_2 = Artist.new(@artist_2_attrs)
  end

  def test_it_exists
    assert_instance_of Curator, @curator
  end

  def test_it_has_no_artists_or_photographs_by_default
    assert_equal [], @curator.artists
    assert_equal [], @curator.photographs
  end

  def test_it_can_add_photograph_objects_from_attribute_list
    Photograph.expects(:new).with(@photo_1_attrs).returns(@photo_1)
    @curator.add_photograph(@photo_1_attrs)

    Photograph.expects(:new).with(@photo_2_attrs).returns(@photo_2)
    @curator.add_photograph(@photo_2_attrs)

    actual = @curator.photographs

    assert_equal [@photo_1, @photo_2], actual
  end

  def test_it_can_add_artist_objects_from_attribute_list
    Artist.expects(:new).with(@artist_1_attrs).returns(@artist_1)
    @curator.add_artist(@artist_1_attrs)

    Artist.expects(:new).with(@artist_2_attrs).returns(@artist_2)
    @curator.add_artist(@artist_2_attrs)

    actual = @curator.artists

    assert_equal [@artist_1, @artist_2], actual
  end

  def test_it_can_find_artists_by_id
    Artist.stubs(:new).returns(@artist_1, @artist_2)
    @curator.add_artist(@artist_1_attrs)
    @curator.add_artist(@artist_2_attrs)

    assert_equal @artist_1, @curator.find_artist_by_id("1")
  end
end
