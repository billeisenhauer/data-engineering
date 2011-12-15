require 'spec_helper'

describe OrderLineItem do
  
  before(:each) do
    @order = Factory.create(:order)
    @product = Factory.create(:product)
    @attr = { :order => @order, :product => @product, :quantity => 10.00 }
  end
  
  describe 'validations' do

    it "should create a new instance given valid attributes" do
      OrderLineItem.create!(@attr)
    end
    
    it "should be invalid without a product" do
      line_item = OrderLineItem.new(:order => @order, :quantity => 10.00)
      line_item.should_not be_valid
      line_item.should have(1).error_on(:product)
    end
    
    it 'should require quantity greater than zero' do
      line_item = OrderLineItem.new(:order => @order, :product => @product, :quantity => 0)
      line_item.should_not be_valid
      line_item.should have(1).error_on(:quantity)
    end
    
  end
  
  describe 'totaling' do
    
    it 'should total 0 with no product' do
      line_item = OrderLineItem.new
      line_item.total.should eql(0)
    end
    
    it 'should total 0 with no quantity' do
      line_item = OrderLineItem.new(:product => @product)
      line_item.total.should eql(0)
    end
    
    it 'should total with product and quantity' do
      line_item = OrderLineItem.new(:product => @product, :quantity => 2)
      expected_total = @product.price * 2
      line_item.total.should eql(expected_total)
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
