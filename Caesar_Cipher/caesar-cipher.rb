def caesar_cipher(texts, shift) 
  alphabet = [
    "a", "b", "c", "d", "e", "f", "g", 
    "h", "i", "j", "k", "l", "m", "n", 
    "o", "p", "q", "r", "s", "t", "u", 
    "v", "w", "x", "y", "z",
  ]

  letters = texts.split("")

    shifted = letters.map do |letter| 
    if alphabet.include?(letter)
      index = alphabet.find_index(letter)
      index = (index + shift) % 26
      alphabet[index]
    else
      letter
    end
  end

  puts shifted.join("")

end

puts "What would you like to encrypt?"
texts = gets().chomp
puts "What is your shift?"
shift = gets().chomp.to_i

puts "your text."
caesar_cipher(texts, shift)



