Factory.define(:product) do |p|
  p.description { Faker::Lorem.words[0] }
  p.price       10.00
  p.association :merchant, :factory => :merchant
end