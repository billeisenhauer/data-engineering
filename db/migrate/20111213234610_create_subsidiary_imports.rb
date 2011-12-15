class CreateSubsidiaryImports < ActiveRecord::Migration
  
  def change
    create_table :subsidiary_imports do |t|
      t.string   :state, :default => "uploaded", :null => false
      t.string   :tsv_file_name, :tsv_content_type
      t.integer  :tsv_file_size
      t.datetime :tsv_updated_at
      t.float    :gross_revenue, :default => 0.0, :null => false
      t.timestamps
    end
  end
  
end
