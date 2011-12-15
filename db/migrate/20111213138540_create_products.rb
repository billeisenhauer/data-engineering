class CreateProducts < ActiveRecord::Migration
  
  def change
    create_table :products do |t|
      t.references :merchant
      t.string :description, :limit => 100, :null => false
      t.float :price, :default => 0.0, :null => false
      t.timestamps
    end
    add_index :products, :merchant_id
  end
  
end
