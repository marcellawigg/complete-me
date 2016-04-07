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
    path = @completion.root.child["p"].child["i"].child["z"].child["z"].child["a"].value
    assert_equal path,"pizza"
  end

  def test_it_increases_the_count_by_1_when_single_item_inserted
    @completion.insert("pizza")
    assert_equal @completion.count,1
  end
  # work on refactoring testing. Dried out, in one place, and used, everywhere. Create trie with
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
    path = @completion.root.child["p"].child["i"].child["z"].child["z"].child["a"].value
    assert_equal "pizza",path
  end

  def test_it_populates_dictionary_into_the_trie
    @completion.populate(@dictionary)
    assert_equal @completion.count,@completion.populate(@dictionary).count
  end

  def test_it_tracks_the_number_of_times_item_selected_when_one_item_select
    @completion.insert("pizza")
    @completion.insert("pizzazz")
    @completion.suggest("piz")
    @completion.select("piz","pizzazz")
    assert_equal @completion.suggest("piz"),["pizzazz","pizza"]
  end

  def test_it_tracks_the_number_of_times_item_selected_when_multiple_items_select
    @completion.insert("pizza")
    @completion.insert("pizzazz")
    @completion.insert("pizzicato")
    @completion.suggest("piz")
    @completion.select("piz","pizzazz")
    @completion.select("piz","pizza")
    @completion.select("piz","pizzazz")
    assert_equal @completion.suggest("piz"),["pizzazz","pizza","pizzicato"]
  end

  def test_it_provides_word_when_that_word_is_suggested
    @completion.insert("id")
    @completion.insert("idiot")
    @completion.insert("ideological")
    @completion.insert("idiopathic")
    assert_equal @completion.suggest("i"), ["id", "idiot", "idiopathic", "ideological"]
  end

  def test_it_tracks_letters_specifically
    @completion.insert("pizza")
    @completion.insert("pizzazz")
    @completion.select("piz","pizzazz")
    assert_equal @completion.suggest("piz"),["pizzazz","pizza"]
    assert_equal@completion.suggest("pi"),["pizza","pizzazz"]
  end

end
