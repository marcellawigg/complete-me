class CompleteMe
  attr_reader :all_words, :count
  def initialize
    @all_words = []
    @count = 0
  end

  def insert(word)
    @all_words << word
    @count+= 1
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
#def suggest(word)
