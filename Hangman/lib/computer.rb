# frozen_string_literal: true

# Gets the word from googles-1000-english-no-swears.txt
class Computer
  def word
    full_word_list = File.open 'google-10000-english-no-swears.txt', 'r'

    word_list = []

    full_word_list.each do |line|
      line = line.chomp
      word_list << line if line.length.between?(5, 12)
    end

    word_list.sample
  end
end
