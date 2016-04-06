require 'minitest/autorun'
require 'minitest/pride'
require './lib/node'

class NodeTest < MiniTest::Test

  def setup
    @node = Node.new
  end

  def test_it_initially_sets_end_word_to_false
    refute @node.end_word
    assert_equal @node.end_word,false
  end

  def test_it_begins_new_node_with_link_as_empty_hash
    assert_equal @node.link,{}
  end

  def test_it_begins_with_weight_empty_hash
    assert_equal @node.weight,{}
  end
end
