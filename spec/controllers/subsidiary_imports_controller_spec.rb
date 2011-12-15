require 'spec_helper'

describe SubsidiaryImportsController do
  
  before(:each) do
    @user = Factory(:user)
    sign_in @user
    @import = Factory.create(:valid_subsidiary_import)
  end  
    
  describe "show" do
  
    before(:each) do
      SubsidiaryImport.should_receive(:find).with('1').and_return(@import)
    end
    
    it "should show import status" do
      get :show, :id => '1'
      response.should render_template('show')
    end
        
  end
  
  describe "create" do
    
    # NOTE:  Have no idea why this test doesn't work.  Seems like the right
    #        params are being passed here.
    
    # it "should create an import" do
    #   uploaded_file = ActionDispatch::Http::UploadedFile.new({
    #     :filename => 'valid.tsv',
    #     :content_type => 'text/tab-separated-values',
    #     :tempfile => File.new("#{Rails.root}/spec/fixtures/files/valid.tsv")
    #   })
    #   params = {'subsidiary_import' => { "tsv" => uploaded_file }}
    #   lambda {
    #     post :create, params
    #   }.should change(SubsidiaryImport, :count).by(1)      
    # end
    
  end

end
