Factory.sequence :merchant_name do |n|
  "Merchant Name #{n}"
end

Factory.define(:merchant) do |m|
  m.name { Factory.next(:merchant_name) }
  m.address "123 Main St."
end