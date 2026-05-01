def substrings(string, dictionary) 
  sub_strings = {}
  string.downcase!()

  dictionary.each do |word|
    match = string.scan(word).length
    if match != 0
      sub_strings[word] = match
    end
  end

  sub_strings
end

dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]
["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]
 
substrings("Howdy partner, sit down! How's it going",dictionary)

