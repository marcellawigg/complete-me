require "./lib/node"

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

  def create_path(word,node,value)
    if word.empty?
      node.value = value
      node.end_word = true
    else
      letter = word.shift
      value += letter
      if node.link[letter].nil?
        node.link[letter] = Node.new
        create_path(word,node.link[letter],value)
      else
        create_path(word,node.link[letter],value)
      end
    end
  end

  def suggest(value,node=root)
    known_so_far = value.chars
    suggestion_list = traverse_trie(known_so_far,node)
    sort_weights(value,suggestion_list)
  end

  def select(value,word_with_weight)
    value_letters = value.chars
    traverse_tree(value_letters,node=root).each do |node|
      if node.value == word_with_weight
        node.weight[value] += 1
      end
    end
    suggest(value,node)
  end

  def traverse_trie(value,node)
    letter = value.shift
    if node.link.has_key?(letter)
      traverse_trie(value,node.link[letter])
    else
      suggestion_list = []
      if node.end_word
        suggestion_list.push(node)
      end
      traverse_other_paths(node,suggestion_list)
    end
  end

  def traverse_other_paths(node,suggestion_list)
    node.link.each_value do |n|
      if node.end_word
        suggestion_list.push(node)
      end
      traverse_other_paths(node,suggestion_list)
    end
    suggestion_list
  end

  def sort_weights(value, list)
    sorted = list.sort_by do |i|
      i.weight[value] * -1
    end
    sorted.map do |i| i.value
    end
  end


  def convert_file_to_array(file)
    word_array = []
    file.each_line do |line|
      word_array << line
    end
    word_array
  end


  def populate(file)
    convert_file_to_array(file).each do |word|
      insert(word)
    end
  end
end
