class Node
  attr_accessor :child, :weight, :value, :end_word
  def initialize(end_word = false, child = {}, weight = Hash.new(0), value = '')
    @child = child
    @end_word = end_word
    @weight = weight
    @value = value
  end
end
