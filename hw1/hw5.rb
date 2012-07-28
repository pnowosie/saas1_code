class String
  def palindrome?
    x = self.gsub(/\W/, "")
    x.casecmp(x.reverse) == 0
  end
end

module Enumerable
  def palindrome?
    return false if not self.respond_to? :each
    
    ar = self.map { |elt| elt }   # gets array
    ar == ar.reverse
  end
end

p "Testing: Palindromes"
p "A man, a plan, a canal -- Panama".palindrome?
p "Doo bee doo bee doo".palindrome?


p [1, 2, 3, 2, 1].palindrome?
p [[1,2], 2, 3, 2, [1,2]].palindrome?
p %w{ ala ola ala}.palindrome?
p (1..5).palindrome?

class Numeric
  @@currencies = {'yen' => 0.013, 'euro' => 1.292, 'rupee' => 0.019, 'dollar' => 1.000}
  def method_missing(method_id)
    singular_currency = method_id.to_s.gsub( /s$/, '')
    if @@currencies.has_key?(singular_currency)
      self * @@currencies[singular_currency]
    else
      super
    end
  end
  
  def in(currency)
    self / 1.send(currency)   # following DRY principle
  end
end

p "Testing: Currencies"
p 2.rupee.in(:dollar).between?(0.037, 0.039)
p 3.yen.in(:dollar).between?(0.038, 0.040)
p 6.euro.in(:dollar).between?(7.75, 7.76)

p 2.rupees.in(:dollars).between?(0.037, 0.039)
p 3.yen.in(:dollars).between?(0.038, 0.040)
p 6.euros.in(:dollars).between?(7.75, 7.76)

p 5.rupees.in(:yen).between?(7.2, 7.4)


class Class
  def attr_accessor_with_history(attr_name)
    attr_name = attr_name.to_s   # make sure it's a string
    attr_reader attr_name        # create the attribute's getter
    attr_reader attr_name+"_history" # create bar_history getter
    
    #  initialize here seems doesn't work, variable is nil in setter
    #  @#{attr_name}_history = [ @#attr_name ]
    
    class_eval %Q{
      def #{attr_name}=(value)
        @#{attr_name}_history = [nil] if @#{attr_name}_history.nil?
        @#{attr_name}_history.push value
      end
    }
  end
end

class Foo 
  attr_accessor_with_history :bar
end

p "Testing: Accessor with history"
f = Foo.new     # => #<Foo:0x127e678>
f.bar = 3       # => 3
f.bar = :wowzo  # => :wowzo
f.bar = 'boo!'  # => 'boo!'
p f.bar_history # => [nil, 3, :wowzo, 'boo!']