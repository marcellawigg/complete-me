require 'minitest/autorun'
require 'minitest/pride'
require './lib/complete_me'
require './lib/node'

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
    assert_equal @completion.count,1
    assert_equal @completion.root.link["p"].link["i"].link["z"].link["z"].link["a"].value,"pizza"
  end

  def test_it_increases_count_when_multiple_words_added
    @completion.insert("pizza")
    @completion.insert("pizzazz")
    assert_equal @completion.count,2
  end

  

  def test_it_takes_a_file_of_words_and_makes_an_array_with_length_lines_in_file
    assert_equal @completion.convert_file_to_array(@dictionary).length,235886
  end

end
