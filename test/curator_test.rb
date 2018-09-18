require_relative 'test_helper'
require './lib/curator'

class CuratorTest < Minitest::Test
  def setup
    @curator = Curator.new
  end
  def test_it_exists
    assert_instance_of Curator, @curator
  end
end
