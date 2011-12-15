Factory.define(:subsidiary_import) do |si|
  si.state  SubsidiaryImport::UPLOADED
end

Factory.define(:valid_subsidiary_import, :parent => :subsidiary_import) do |si| 
  si.tsv File.new(Rails.root + 'spec/fixtures/files/valid.tsv')
end 

Factory.define(:invalid_subsidiary_import, :parent => :subsidiary_import) do |si| 
  si.tsv File.new(Rails.root + 'spec/fixtures/files/invalid.html')
end