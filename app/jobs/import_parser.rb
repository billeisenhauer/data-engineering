require 'csv'

class ImportParser < Struct.new(:import_id)
  
  cattr_accessor :logger
  
  def perform
    import = SubsidiaryImport.find(import_id)
    parser = create_parser(import)
    parse(parser, import)
  end
  
  private
  
    def create_parser(import)
      file_data = import.file_data
      CSV.new(file_data, :headers => true, :col_sep => "\t")
    end
    
    def create_order(row)
      ActiveRecord::Base.transaction do 
        customer  = get_customer(row)
        merchant  = get_merchant(row)
        product   = get_product(merchant, row)
        quantity  = row['purchase count']
        order = Order.new(:customer => customer)
        order.order_line_items.build(:product => product, :quantity => quantity)
        order.save!
        order
      end
    rescue Exception => e
      puts "Problem with row (exception):\n"
      row.to_hash.each { |key, value| puts "#{key} => #{value}" }
      puts e.message
    end
    
    def get_customer(row)
      name = row['purchaser name']
      Customer.find_or_create_by_name(name)
    end
    
    def get_merchant(row)
      name    = row['merchant name']
      address = row['merchant address']
      Merchant.find_or_create_by_name(name, :address => address)
    end
    
    def get_product(merchant, row)
      product_desc  = row['item description']
      product_price = row['item price']
      merchant.products.find_or_create_by_description(product_desc, :price => product_price)
    end
    
    def parse(parser, import)
      total = 0.0
      parser.each do |row|
        order = create_order(row)
        total += order.total
      end
      import.import!(total)
    end
  
end