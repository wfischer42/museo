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
      id: '1',
      name: 'Rue Mouffetard, Paris (Boy with Bottles)',
      artist_id: '1',
      year: '1954'
    }
    @photo_2_attrs = {
      id: '2',
      name: 'Moonrise, Hernandez',
      artist_id: '2',
      year: '1941'
    }
    @photo_3_attrs = {
      id: '3',
      name: 'Identical Twins, Roselle, New Jersey',
      artist_id: '3',
      year: '1967'
    }
    @photo_4_attrs = {
      id: '4',
      name: 'Child with Toy Hand Grenade in Central Park',
      artist_id: '3',
      year: '1962'
    }

    @photo_1 = Photograph.new(@photo_1_attrs)
    @photo_2 = Photograph.new(@photo_2_attrs)
    @photo_3 = Photograph.new(@photo_3_attrs)
    @photo_4 = Photograph.new(@photo_4_attrs)
  end

  def setup_artists
    @artist_1_attrs = {
      id: '1',
      name: 'Henri Cartier-Bresson',
      born: '1908',
      died: '2004',
      country: 'France'
    }
    @artist_2_attrs = {
      id: '2',
      name: 'Ansel Adams',
      born: '1902',
      died: '1984',
      country: 'United States'
    }
    @artist_3_attrs = {
      id: '3',
      name: 'Diane Arbus',
      born: '1923',
      died: '1971',
      country: 'United States'
    }

    @artist_1 = Artist.new(@artist_1_attrs)
    @artist_2 = Artist.new(@artist_2_attrs)
    @artist_3 = Artist.new(@artist_3_attrs)
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

    assert_equal @artist_1, @curator.find_artist_by_id('1')
  end

  def test_it_can_find_photographs_by_id
    Photograph.stubs(:new).returns(@photo_1, @photo_2)
    @curator.add_photograph(@photo_1_attrs)
    @curator.add_photograph(@photo_2_attrs)

    assert_equal @photo_2, @curator.find_photograph_by_id('2')
  end

  def test_it_can_find_photographs_by_artist
    Photograph.stubs(:new).returns(@photo_1, @photo_2, @photo_3, @photo_4)
    @curator.add_photograph(@photo_1_attrs)
    @curator.add_photograph(@photo_2_attrs)
    @curator.add_photograph(@photo_3_attrs)
    @curator.add_photograph(@photo_4_attrs)

    Artist.stubs(:new).returns(@artist_1, @artist_2, @artist_3)
    @curator.add_artist(@artist_1_attrs)
    @curator.add_artist(@artist_2_attrs)
    @curator.add_artist(@artist_3_attrs)

    actual = @curator.find_photographs_by_artist(@artist_3)

    assert_equal [@photo_3, @photo_4], actual
  end

  def test_it_can_find_artists_with_multiple_photographs
    Photograph.stubs(:new).returns(@photo_1, @photo_2, @photo_3, @photo_4)
    @curator.add_photograph(@photo_1_attrs)
    @curator.add_photograph(@photo_2_attrs)
    @curator.add_photograph(@photo_3_attrs)
    @curator.add_photograph(@photo_4_attrs)

    Artist.stubs(:new).returns(@artist_1, @artist_2, @artist_3)
    @curator.add_artist(@artist_1_attrs)
    @curator.add_artist(@artist_2_attrs)
    @curator.add_artist(@artist_3_attrs)

    actual = @curator.artists_with_multiple_photographs

    assert_equal [@artist_3], actual
  end

  def test_it_can_find_artists_from_country
    Photograph.stubs(:new).returns(@photo_1, @photo_2, @photo_3, @photo_4)
    @curator.add_photograph(@photo_1_attrs)
    @curator.add_photograph(@photo_2_attrs)
    @curator.add_photograph(@photo_3_attrs)
    @curator.add_photograph(@photo_4_attrs)

    Artist.stubs(:new).returns(@artist_1, @artist_2, @artist_3)
    @curator.add_artist(@artist_1_attrs)
    @curator.add_artist(@artist_2_attrs)
    @curator.add_artist(@artist_3_attrs)

    actual = @curator.artists_from('United States')

    assert_equal [@artist_2, @artist_3], actual
  end

  def test_it_can_find_photographs_by_artists_from_country
    Photograph.stubs(:new).returns(@photo_1, @photo_2, @photo_3, @photo_4)
    @curator.add_photograph(@photo_1_attrs)
    @curator.add_photograph(@photo_2_attrs)
    @curator.add_photograph(@photo_3_attrs)
    @curator.add_photograph(@photo_4_attrs)

    Artist.stubs(:new).returns(@artist_1, @artist_2, @artist_3)
    @curator.add_artist(@artist_1_attrs)
    @curator.add_artist(@artist_2_attrs)
    @curator.add_artist(@artist_3_attrs)

    actual = @curator.photographs_taken_by_artists_from('United States')

    assert_equal [@photo_2, @photo_3, @photo_4], actual
  end

  def test_it_can_load_photographs_from_csv_file
    @curator.load_photographs('./data/photographs.csv')

    assert @curator.photographs.all? {|photo| photo.class == Photograph}
    assert_equal 4, @curator.photographs.length
    assert_equal 'Identical Twins, Roselle, New Jersey', @curator.photographs[2].name
  end

  def test_it_can_load_artists_from_csv_file
    @curator.load_artists('./data/artists.csv')
    assert @curator.artists.all? {|artist| artist.class == Artist}
    assert_equal 6, @curator.artists.length

    assert_equal 'Diane Arbus', @curator.artists[2].name
  end

  def test_it_can_find_photos_taken_in_year_range
    @curator.load_artists('./data/artists.csv')
    @curator.load_photographs('./data/photographs.csv')
    actual = @curator.photographs_taken_between(1950..1965)
    expected = @curator.photographs.values_at(0, 3)

    assert_equal expected, actual
  end

  def test_it_can_group_an_artists_photos_by_age
    @curator.load_artists('./data/artists.csv')
    @curator.load_photographs('./data/photographs.csv')

    diane_arbus = @curator.find_artist_by_id('3')
    actual = @curator.artists_photographs_by_age(diane_arbus)
    expected = { 44 => 'Identical Twins, Roselle, New Jersey',
                 39 => 'Child with Toy Hand Grenade in Central Park' }

    assert_equal expected, actual
  end

  def test_it_can_group_multiple_photos_of_the_same_age
    #Because the spec didn't suggest how to handle that
    @curator.load_artists('./data/artists.csv')
    @curator.load_photographs('./data/photographs.csv')

    @photo_4.stubs(name: 'This Photograph Was Never Taken')
    Photograph.stubs(:new).returns(@photo_4)
    @curator.add_photograph(@photo_4_attrs)

    diane_arbus = @curator.find_artist_by_id('3')
    actual = @curator.artists_photographs_by_age(diane_arbus)
    expected = { 44 => 'Identical Twins, Roselle, New Jersey',
                 39 => ['Child with Toy Hand Grenade in Central Park',
                        'This Photograph Was Never Taken'] }

    assert_equal expected, actual
  end
end
