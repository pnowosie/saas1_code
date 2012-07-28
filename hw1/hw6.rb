class CartesianProduct
  include Enumerable
  
  def initialize(l1, l2)
    @product = l1.product l2
  end
  
  def each
    @product.each { |p| yield p }
  end
end

c = CartesianProduct.new([:a,:b], [4,5])
c.each { |elt| puts elt.inspect }
# [:a, 4]
# [:a, 5]
# [:b, 4]
# [:b, 5]

puts "Testing: Sample lists in reversed order"
c = CartesianProduct.new([4,5], [:a,:b])
c.each { |elt| puts elt.inspect }

c = CartesianProduct.new([:a,:b], [])
c.each { |elt| puts elt.inspect }
# (nothing printed since Cartesian product
# of anything with an empty collection is empty)

puts "Testing: Empty array on left"
c = CartesianProduct.new([], [:a,:b])
