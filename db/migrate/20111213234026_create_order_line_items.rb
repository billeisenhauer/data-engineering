class CreateOrderLineItems < ActiveRecord::Migration
  
  def change
    create_table :order_line_items do |t|
      t.references :order
      t.references :product
      t.integer :quantity, :null => false
      t.timestamps
    end
    add_index :order_line_items, :order_id
    add_index :order_line_items, :product_id
  end
  
end
