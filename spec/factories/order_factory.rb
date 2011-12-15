Factory.define(:order_line_item) do |li|
  li.quantity    1
  li.association :product
end

Factory.define(:order) do |o|
  o.association :customer, :factory => :customer
end

Factory.define(:order_with_line_item, :parent => :order) do |o|
  o.after_build do |order| 
    order.order_line_items << Factory.build(:order_line_item)
  end
end