require 'spec_helper'

describe Customer do
  
  before(:each) do
    @attr = { :name => "Bill Eisenhauer" }
  end
  
  describe 'validations' do

    it "should create a new instance given valid attributes" do
      Customer.create!(@attr)
    end
  
    it "should be invalid without name" do
      customer = Customer.new
      customer.should_not be_valid
      customer.should have(1).error_on(:name)
    end
  
    it "should be invalid with long name" do
      long_name = 'x' * (Customer::NAME_MAX_LENGTH + 1)
      customer = Customer.new(:name => long_name)
      customer.should_not be_valid
      customer.should have(1).error_on(:name)
    end
    
    it 'should be invalid with duplicate name' do
      Customer.create!(@attr)
      dupe_customer = Customer.new(@attr)
      dupe_customer.should_not be_valid
    end
    
  end
  
end
