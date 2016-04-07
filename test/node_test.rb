require './test/test_helper'
require './lib/node'

class NodeTest < MiniTest::Test

  def setup
    @node = Node.new
  end

  def test_it_initially_sets_end_word_to_false
    refute @node.is_word
    assert_equal @node.is_word,false
  end

  def test_it_begins_new_node_with_child_as_empty_hash
    assert_equal @node.child,{}
  end

  def test_it_begins_with_weight_empty_hash
    assert_equal @node.weight,{}
  end

  def test_it_defaults_to_true_for_leaf_node?
    assert_equal @node.leaf_node?,true
    refute_equal @node.leaf_node?,false
  end

end
