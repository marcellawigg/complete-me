class Node
  attr_accessor :child, :weight, :value, :end_word
  def initialize(end_word = false, child = {}, weight = Hash.new(0), value = '')
    @child = child
    @end_word = end_word
    @weight = weight
    @value = value
  end

  def has_child_nodes?
    child.empty? == false
  end

  def exists_child?(letter)
    child.has_key?(letter)
  end

  def has_branches_below?
    if child.length >= 2
      true
    elsif child.length == 1
      self.child.has_branches_below?
    else
      false
    end
  end

end
