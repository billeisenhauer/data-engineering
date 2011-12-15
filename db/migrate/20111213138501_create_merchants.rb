class CreateMerchants < ActiveRecord::Migration
  
  def change
    create_table :merchants do |t|
      t.string :name, :limit => 100, :null => false
      t.string :address, :limit => 200, :null => false
      t.timestamps
    end
  end
  
end
