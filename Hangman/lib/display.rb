# frozen_string_literal: true

# Creates the display
class Display
  attr_accessor :num

  def create_word_bar(num)
    Array.new(num) { '_' }
  end
end
