require 'spec_helper'

describe SubsidiaryImport do
    
  before(:each) do 
    @valid_file = File.new(File.expand_path("../fixtures/files/valid.tsv", File.dirname(__FILE__)), 'r')
    @valid_attributes = { :tsv => @valid_file }
  end
    
  describe 'validations' do
    
    it "should create a new instance given valid attributes" do
      SubsidiaryImport.create!(@valid_attributes)
    end
  
    it "should be invalid without tsv file" do
      import = SubsidiaryImport.new
      import.should_not be_valid
      import.should have(1).error_on(:tsv)
    end
  
    it "should be invalid with invalid tsv file" do
      import = Factory.build(:invalid_subsidiary_import)    
      import.should_not be_valid
      import.should have(1).error_on(:tsv_content_type)
    end
  
    it "should humanize attributes" do
      SubsidiaryImport.human_attribute_name('tsv').should eql(SubsidiaryImport::TSV_LABEL)
    end
  
  end
  
  describe 'processing' do
    
    before(:each) do
      @import_1 = SubsidiaryImport.create!(@valid_attributes)
      @import_2 = SubsidiaryImport.create!(@valid_attributes)
      @import_3 = SubsidiaryImport.create!(@valid_attributes)
    end
    
    it 'should set state for imported imports' do
      @import_3.import!(50.00)
      @import_3.state.should eql(SubsidiaryImport::IMPORTED)
    end
    
    it 'should return array of imported imports' do
      SubsidiaryImport.uploaded([@import_1, @import_2])
    end
    
    it 'should return array of imported imports' do
      @import_3.import!(50.00)
      SubsidiaryImport.imported([@import_3])
    end
    
  end
  
end
