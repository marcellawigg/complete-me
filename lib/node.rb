class Node
  attr_accessor :child, :weight, :value, :is_word
  def initialize(is_word = false, child = {}, weight = Hash.new(0), value = '',selections={})
    @child = child
    @is_word = is_word
    @weight = weight
    @value = value
  end
  def leaf_node?
    child.empty?
  end

end
