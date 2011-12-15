require 'spec_helper'

describe ImportParser do

  before(:each) do
    @import = Factory.create(:valid_subsidiary_import)
  end
  
  it 'should parse the correct total' do
    ip = ImportParser.new(@import.id)
    lambda {
      lambda {
        lambda { 
          lambda {
            ip.perform
          }.should change(Order, :count).by(4)
        }.should change(Customer, :count).by(3)
      }.should change(Merchant, :count).by(3)
    }.should change(Product, :count).by(3)
    @import.reload
    @import.state.should eql(SubsidiaryImport::IMPORTED)
    @import.gross_revenue.should eql(95.00)
    
  end
  
end