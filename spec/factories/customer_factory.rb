Factory.sequence :customer_name do |n|
  "Product Name #{n}"
end

Factory.define(:customer) do |p|
  p.name { Factory.next(:customer_name) }
end