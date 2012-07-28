
class Dessert
  def initialize(name, calories)
    @name, @calories = name, calories
  end
  
  attr_accessor :name, :calories
  
  def healthy?
    @calories < 200
  end
  
  def delicious?
    true
  end
  
  def to_s ; "Dessert (name=#@name, calories=#@calories)"; end
end

class JellyBean < Dessert
  def initialize(name, calories, flavor)
    super(name, calories)
    @flavor = flavor
  end
  
  attr_accessor :flavor
  
  def delicious?
    not (@flavor =~ /black licorice/i)
  end
  
  def to_s ; "JellyBean (name=#@name, calories=#@calories, flavor=#@flavor)"; end
end

# Testing...
d = Dessert.new('papka', 120)

puts d
d.calories = 135
puts d
puts d.delicious?
puts d.healthy?

d.calories = 200 
puts d
puts d.healthy?

jb = JellyBean.new('Mamalyga', 201, 'black licorice')
puts jb
puts jb.healthy?
puts jb.delicious?
