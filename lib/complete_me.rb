  class CompleteMe
    attr_accessor :all_words, :count
    def initialize
      @all_words = []
      @count = 0
    end

    def insert(word)
      @all_words << word
      @count+= 1
      @count
    end
end
