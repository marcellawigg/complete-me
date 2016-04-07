class Node
  attr_accessor :child, :weight, :value, :is_word
  def initialize
    @child = Hash.new
    @is_word = false
    @weight = Hash.new(0)
    @value = ''
  end
  def leaf_node?
    child.empty?
  end

end
