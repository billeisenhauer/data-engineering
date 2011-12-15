class SubsidiaryImportsController < ApplicationController
  
  before_filter :authenticate_user!
  before_filter :load_subsidiary_import, :only => :show
  
  def new
    @import = SubsidiaryImport.new
  end
  
  def create
    @import = SubsidiaryImport.new(params[:subsidiary_import])
    @import.save!
    flash[:notice] = "File uploaded and scheduled for processing."
    redirect_to subsidiary_import_path(@import)
  rescue ActiveRecord::RecordInvalid
    render :action => 'new'
  end
  
  protected
  
    def load_subsidiary_import
      @import = SubsidiaryImport.find(params[:id])
    end
  
end
