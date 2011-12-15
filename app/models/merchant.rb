class Merchant < ActiveRecord::Base
  
  ### ASSOCIATIONS ###
  
  has_many :products, :dependent => :delete_all
  
  ### VALIDATIONS ###
  
  NAME_MAX_LENGTH    = columns_hash['name'].limit
  ADDRESS_MAX_LENGTH = columns_hash['address'].limit
  
  validates :name,
            :presence => true,
            :length   => { :maximum => NAME_MAX_LENGTH },
            :uniqueness => true
  validates :address,
            :presence => true,
            :length   => { :maximum => ADDRESS_MAX_LENGTH }
  
end
