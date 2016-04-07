require_relative "../lib/node"

class CompleteMe
  attr_reader :count, :root
  def initialize
    @count = 0
    @root = Node.new
  end

  def insert(word,node=root,value="")
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

  def suggest(substring,node=@root)
    known_so_far = substring.chars
    suggestion_list = traverse_trie(known_so_far,node)
    sort_weights(substring,suggestion_list)
  end

  def select(substring,word_with_weight)
    substring_letters = substring.chars
    traverse_trie(substring_letters,node=root).each do |node|
      if node.value == word_with_weight
        node.weight[substring] += 1
      end
    end
    suggest(substring,node)
  end

  def create_path(word,node,value)
    if word.empty?
      node.value = value
      node.is_word = true
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

  def traverse_trie(substring,node)
    letter = substring.shift
    if node.child.has_key?(letter)
      traverse_trie(substring,node.child[letter])
    else
      suggestion_list = []
      if node.is_word
        suggestion_list.push(node)
      end
      traverse_other_paths(node,suggestion_list)
    end
  end

  def traverse_other_paths(node,list)
    node.child.each_value do |node|
      if node.is_word
        list.push(node)
      end
      traverse_other_paths(node,list)
    end
    list
  end

  def sort_weights(substring, list)
    sorted_list = list.sort_by do |i|
      -i.weight[substring]
    end
    sorted_list.map do |i|
      i.value
    end
  end

end
