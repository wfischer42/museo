require_relative 'test_helper'
require './lib/curator'

class CuratorTest < Minitest::Test
  def setup
    @curator = Curator.new
  end

  def test_it_exists
    assert_instance_of Curator, @curator
  end

  def test_it_has_no_artists_or_photographs_by_default
    assert_equal [], @curator.artists
    assert_equal [], @curator.photographs
  end
end
