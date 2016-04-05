require 'minitest/autorun'
require 'minitest/pride'
require './lib/complete_me'

class CompleteMeTest < MiniTest::Test
  attr_reader :completion, :dictionary

  def setup
    @completion = CompleteMe.new
    @dictionary = File.read("/usr/share/dict/words")
  end

  def test_it_adds_a_single_word
    @completion.insert("pizza")
    assert_equal @completion.count,1
    assert_equal @completion.all_words,["pizza"]
  end

  def test_it_takes_a_file_of_words_and_makes_an_array_of_length_of_lines_in_file
    assert_equal @completion.convert_file_to_array(@dictionary).length,235886
  end

  def test_it_populates_the_dictionary_and_adds_to_count
    @completion.populate(@dictionary)
    assert_equal @completion.count,235886
  end
end
