class OrderLineItem < ActiveRecord::Base
  include Indestructable
  
  ### ASSOCIATIONS ###
  
  belongs_to :order
  belongs_to :product
  
  ### VALIDATIONS ###
  
  validates :product,
            :presence => true
  validates :quantity,
            :presence => true,
            :numericality => { :greater_than => 0 }
                 
  ### TOTALING ###

  def total
    return 0 unless quantity && product
    quantity * product.price
  end            
  
end
