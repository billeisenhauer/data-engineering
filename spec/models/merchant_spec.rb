require 'spec_helper'

describe Merchant do
 
  before(:each) do
    @attr = { :name => "Dick's Sporting Goods", :address => '100 Main St, Dallas, TX 75000' }
  end
  
  describe 'validations' do

    it "should create a new instance given valid attributes" do
      Merchant.create!(@attr)
    end
  
    it "should be invalid without name" do
      merchant = Merchant.new
      merchant.should_not be_valid
      merchant.should have(1).error_on(:name)
    end
  
    it "should be invalid with long name" do
      long_name = 'x' * (Merchant::NAME_MAX_LENGTH + 1)
      merchant = Merchant.new(:name => long_name)
      merchant.should_not be_valid
      merchant.should have(1).error_on(:name)
    end
  
    it "should be invalid without address" do
      merchant = Merchant.new
      merchant.should_not be_valid
      merchant.should have(1).error_on(:address)
    end
  
    it "should be invalid with long address" do
      long_address = 'x' * (Merchant::ADDRESS_MAX_LENGTH + 1)
      merchant = Merchant.new(:address => long_address)
      merchant.should_not be_valid
      merchant.should have(1).error_on(:address)
    end
    
    it 'should be invalid with duplicate name' do
      Merchant.create!(@attr)
      dupe_merchant = Merchant.new(@attr)
      dupe_merchant.should_not be_valid
    end
    
  end
 
 
end
