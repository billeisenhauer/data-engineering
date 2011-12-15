require 'spec_helper'

describe Order do
  
  before(:each) do
    @customer = Factory.create(:customer)
    @attr = { :customer => @customer }
  end
  
  describe 'validations' do
    
    it "should create a new instance given valid attributes" do
      Order.create!(@attr)
    end
    
    it "should be invalid without a customer" do
      order = Order.new
      order.should_not be_valid
      order.should have(1).error_on(:customer)
    end
    
  end
  
  describe 'totaling' do
    
    it 'should total 0 with no line items' do
      order = Order.new
      order.total.should eql(0)
    end
    
    it 'should total with product and quantity' do
      order = Factory.create(:order_with_line_item)
      product = order.order_line_items.first.product
      expected_total = order.order_line_items.size * product.price
      order.total.should eql(expected_total)
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
