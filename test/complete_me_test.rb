require 'minitest/autorun'
require 'minitest/pride'
require './lib/complete_me'

class CompleteMeTest < MiniTest::Test
  attr_reader :completion

  def setup
    @completion = CompleteMe.new
  end

  def test_it_adds_a_single_word
    @completion.insert("pizza")
    assert_equal @completion.count,1
  end

end
