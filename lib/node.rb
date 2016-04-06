class Node
  attr_accessor :link, :weight, :value, :end_word
  def initialize(end_word = false, link = {}, weight = {}, value = '')
    @link = link
    @end_word = end_word
    @weight = weight
    @value = value
  end
end
