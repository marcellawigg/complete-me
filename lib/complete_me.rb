require "./lib/node"

class CompleteMe
  attr_reader :count, :root
  def initialize
    @count = 0
    @root = Node.new
  end

  def insert(word,node=@root,value='')
    word = word.downcase.chars
    @count += 1
    create_path(word,node,value)
  end

  def populate(word_list)
    word_list = word_list.split("\n")
    word_list.each do |word|
      insert(word)
    end
  end

  def create_path(word,node,value)
    if word.empty?
      node.value = value
      node.end_word = true
    else
      letter = word.shift
      value += letter
      if node.child[letter].nil?
        node.child[letter] = Node.new
        create_path(word,node.child[letter],value)
      else
        create_path(word,node.child[letter],value)
      end
    end
  end

  def suggest(substring,node=@root)
    suggestions = traverse_trie(substring.chars,node)
    sort_weights(substring,suggestions)
  end

  def select(substring,word_with_weight)
    substring_letters = substring.chars
    traverse_trie(substring_letters,node=@root).each do |node|
      if node.value == word_with_weight
        node.weight[substring] += 1
      end
    end
    suggest(substring,node)
  end

  def traverse_trie(substring,node)
    letter = substring.shift
    generate_suggestions(node, substring,suggestion_list=[])
    sort_weights(substring,suggestion_list)
  end
end

def generate_suggestions(node, substring,suggestion_list=[])
  suggestion_list = []
  if node.has_child_nodes?
    suggestion_list.push(node)
  else
    node.child.each do |stored_letter,suggestion_list|
      generate_suggestions((substring.insert(-1,stored_letter)),suggestion_list)
    end
    suggestion_list
  end

  def sort_weights(substring, list)
    sorted = list.sort_by do |i| i.weight[substring] * -1
    end
    sorted.map do |i|
      i.value
    end
  end
end
