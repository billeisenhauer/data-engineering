require 'spec_helper'

describe Product do
  
  before(:each) do
    @merchant = Factory.create(:merchant)
    @attr = { :description => "Soccer Ball", :price => 34.99, :merchant => @merchant }
  end
  
  describe 'validations' do
    
    it "should create a new instance given valid attributes" do
      Product.create!(@attr)
    end
  
    it "should be invalid without desc" do
      product = Product.new
      product.should_not be_valid
      product.should have(1).error_on(:description)
    end
    
    it "should be invalid without merchant" do
      product = Product.new
      product.should_not be_valid
      product.should have(1).error_on(:merchant)
    end
  
    it "should be invalid with long desc" do
      long_desc = 'x' * (Product::DESC_MAX_LENGTH + 1)
      product = Product.new(:description => long_desc)
      product.should_not be_valid
      product.should have(1).error_on(:description)
    end
    
    it 'should require price greater than zero' do
      product = Product.new(:price => 0)
      product.should_not be_valid
      product.should have(1).error_on(:price)
    end
    
    it 'should be invalid with duplicate description and merchant' do
      Product.create!(@attr)
      dupe_product = Product.new(@attr)
      dupe_product.should_not be_valid
    end
    
    it 'should be valid with duplicate description, but different merchant' do
      Product.create!(@attr)
      dupe_product = Product.new(@attr)
      dupe_product.merchant = Factory.create(:merchant)
      dupe_product.should be_valid
      
    end
    
  end
  
  describe 'immutability' do
  
    it 'should prevent destroy' do
      product = Factory.create(:product)
      lambda {
        product.destroy
      }.should_not change(Product, :count).by(-1)
    end
    
  end
  
end
