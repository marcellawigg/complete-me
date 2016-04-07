require './test/test_helper'
require './lib/complete_me'

class CompleteMeTest < MiniTest::Test
  attr_reader :completion, :dictionary

  def setup
    @completion = CompleteMe.new
    @dictionary = File.read("/usr/share/dict/words")
  end

  def test_it_creates_new_node_when_root_called
    assert_equal Node,@completion.root.class
  end

  def test_it_inserts_a_single_word_along_path
    @completion.insert("pizza")
    assert_equal @completion.root.child["p"].child["i"].child["z"].child["z"].child["a"].value,"pizza"
  end

  def test_it_increases_the_count_when_single_item_inserted
    @completion.insert("pizza")
    assert_equal @completion.count,1
  end

  def test_it_increases_count_when_multiple_words_added
    @completion.insert("pizza")
    @completion.insert("pizzazz")
    assert_equal @completion.count,2
  end

  def test_it_suggests_a_word_even_when_single_word_added
    @completion.insert("pizza")
    assert_equal @completion.suggest("piz"),["pizza"]
  end

  def test_it_suggests_multiple_words_given_a_single_word
    @completion.insert("pizza")
    @completion.insert("pizzazz")
    assert_equal @completion.suggest("piz"),["pizza","pizzazz"]
  end

  def test_it_populates_dictionary_into_the_trie
    @completion.populate(@dictionary)
    assert_equal @completion.count,235886
  end

  def test_it_deletes_one_word_after_insertion
    @completion.insert("pizza")
    @completion.delete("pizza")
    assert_equal @completion.count,0
  end
end
