def caesar_cipher(texts, shift) 
  lower_alphabet = [
    "a", "b", "c", "d", "e", "f", "g", 
    "h", "i", "j", "k", "l", "m", "n", 
    "o", "p", "q", "r", "s", "t", "u", 
    "v", "w", "x", "y", "z"
  ]
  upper_alphabet = [
    "A", "B", "C", "D", "E", "F", "G", 
    "H", "I", "J", "K", "L", "M", "N", 
    "O", "P", "Q", "R", "S", "T", "U", 
    "V", "W", "X", "Y", "Z"]

  letters = texts.split("")

  shifted = letters.map do |letter| 

    if lower_alphabet.include?(letter)
        index = lower_alphabet.find_index(letter)
        index = (index + shift) % 26
        lower_alphabet[index]
    elsif upper_alphabet.include?(letter)
        index = upper_alphabet.find_index(letter)
        index = (index + shift) % 26
        upper_alphabet[index]
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



