class Upload; end

Factory.define(:upload) do |u|
  u.filename 'valid.tsv'
  u.type     'text/tab-separated-values'
  u.tempfile File.new(Rails.root + 'spec/fixtures/files/valid.tsv')
  u.head     "Content-Disposition: form-data;
              name=\"valid.tsv\"; 
              filename=\"valid.tsv\" 
              Content-Type: text/tab-separated-values\r\n",
end

Factory.define(:invalid_upload, :class => Upload) do |u|
  u.filename 'invalid.html'
  u.type     'text/html'
  u.tempfile File.new(Rails.root + 'spec/fixtures/files/invalid.html')
  u.head     "Content-Disposition: form-data;
              name=\"invalid.html\"; 
              filename=\"invalid.html\" 
              Content-Type: text/html\r\n",
end
