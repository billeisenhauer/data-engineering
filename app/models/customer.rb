class Customer < ActiveRecord::Base
  
  ### ASSOCIATIONS ###
  
  has_many :orders, :dependent => :nullify
  
  ### VALIDATIONS ###
  
  NAME_MAX_LENGTH  = columns_hash['name'].limit
  
  validates :name,
            :presence => true,
            :length   => { :maximum => NAME_MAX_LENGTH },
            :uniqueness => true        
  
end
