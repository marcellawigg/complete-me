require_relative 'test_helper'
require_relative '../lib/complete_me'

class CompleteMeTest < MiniTest::Test
  attr_reader :completion, :dictionary

  def setup
    @completion = CompleteMe.new
    @dictionary = File.read("/usr/share/dict/words")
  end

  def test_it_begins_count_at_zero
    assert_equal @completion.count,0
  end

  def test_it_initializes_root_as_a_complete_me_class_object
    assert_equal @completion.class,CompleteMe
  end

  def test_it_makes_is_word_true_if_word_empty
    assert_equal @completion.insert(''),true
  end

  def test_it_creates_new_node_when_root_called
    assert_equal Node,@completion.root.class
  end

  def test_it_inserts_a_single_word_along_path
    @completion.insert("pizza")
    assert_equal @completion.root.child["p"].child["i"].child["z"].child["z"].child["a"].value,"pizza"
  end

  def test_it_increases_the_count_by_1_when_single_item_inserted
    @completion.insert("pizza")
    assert_equal @completion.count,1
  end

  def test_it_creates_path_when_word_inserted
  assert_equal @completion.insert("yellow"),@completion.create_path("yellow".chars,@root,"")
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

  def test_it_corrects_erroneous_capital_letters_in_insert
    @completion.insert("pIzza")
    assert_equal 1,@completion.count
    assert_equal "pizza",completion.root.child["p"].child["i"].child["z"].child["z"].child["a"].value
  end

  def test_it_populates_dictionary_into_the_trie
    @completion.populate(@dictionary)
    assert_equal @completion.count,235886
  end

  def test_it_provides_word_when_that_word_is_suggested
    @completion.insert("id")
    @completion.insert("idiot")
    @completion.insert("ideological")
    @completion.insert("idiopathic")
    assert_equal @completion.suggest("i"), ["id", "idiot", "idiopathic", "ideological"]
  end
  def test_it_stops_suggesting_deleted_word
    @completion.insert("pizza")
    @completion.delete("pizza")
    refute_equal @completion.suggest("piz"),["pizza"]
  end

end
