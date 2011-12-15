class Order < ActiveRecord::Base
  include Indestructable
  
  ### ASSOCIATIONS ###
  
  belongs_to :customer
  has_many :order_line_items, :dependent => :delete_all
  
  accepts_nested_attributes_for :order_line_items
  
  ### VALIDATIONS ###
  
  validates :customer,
            :presence => true
            
  ### TOTALING ###

  def total
    order_line_items.inject(0) { |sum, li| sum + li.total }
  end          
  
end
