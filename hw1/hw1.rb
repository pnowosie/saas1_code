
def palindrome?(string)
  x = string.gsub(/\W/, "")
  x.casecmp(x.reverse) == 0
end

def count_words(string)
  h = Hash.new {|hash, key| hash[key] = 0}
  string.scan(/\w+\b/) { |w| h[w.downcase] = h[w.downcase]+1 }
  h
end

puts 'Testing...'
puts count_words("A man, a plan, a canal -- Panama")
puts count_words "Doo bee doo bee doo"
