require './test/test_helper'
require './lib/node'

class NodeTest < MiniTest::Test

  def setup
    @node = Node.new
  end

  def test_it_initially_sets_end_word_to_false
    refute @node.end_word
    assert_equal @node.end_word,false
  end

  def test_it_begins_new_node_with_child_as_empty_hash
    assert_equal @node.child,{}
  end

  def test_it_begins_with_weight_empty_hash
    assert_equal @node.weight,{}
  end

  def test_it_returns_true_if_there_are_multiple_branches
    @
end
