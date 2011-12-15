class Product < ActiveRecord::Base
  include Indestructable
  
  ### ASSOCIATIONS ###
  
  belongs_to :merchant
  
  ### VALIDATIONS ###
  
  DESC_MAX_LENGTH = columns_hash['description'].limit
  
  validates :merchant,
            :presence => true
  validates :description,
            :presence => true,
            :length   => { :maximum => DESC_MAX_LENGTH },
            :uniqueness => { :scope => :merchant_id }
  validates :price,
            :presence => true,
            :numericality => { :greater_than => 0 }      
  
end
