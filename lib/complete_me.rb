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

  def suggest(substring,node=root)
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

  def traverse_trie(substring,node)
    letter = substring.shift
    if node.link.has_key?(letter)
      traverse_trie(substring,node.link[letter])
    else
      suggestion_list = []
      if node.end_word
        suggestion_list.push(node)
      end
      traverse_other_paths(node,suggestion_list)
    end
  end

  def traverse_other_paths(node,list)
    node.link.each_value do |node|
      if node.end_word
        list.push(node)
      end
      traverse_other_paths(node,list)
    end
    list
  end

  def sort_weights(substring, list)
    sorted = list.sort_by do |i|
      i.weight[substring]
    end
    sorted.map do |i|
      i.value
    end
  end

  def convert_file_to_array(file)
    word_array = []
    file.each_line do |line|
      word_array.push(line)
    end
    word_array
  end

  def populate(file)
    convert_file_to_array(file).each do |word|
      insert(word)
    end
  end

  def delete(word)
  end
end
