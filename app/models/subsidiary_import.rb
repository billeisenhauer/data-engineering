class SubsidiaryImport < ActiveRecord::Base
  
  TSV_LABEL = "Import file"
  HUMANIZED_COLUMNS = { :tsv => TSV_LABEL }
  TSV_CONTENT_TYPES = ['text/tab-separated-values', 'application/octet-stream']
  UPLOADED = 'uploaded'
  IMPORTED = 'imported'
  
  has_attached_file :tsv
  
  ### SCOPES ###
  
  scope :uploaded, where(:state => UPLOADED)
  scope :imported, where(:state => IMPORTED)
  
  ### VALIDATIONS ###
  
  validates_attachment_presence     :tsv
  validates_attachment_content_type :tsv, :content_type => TSV_CONTENT_TYPES
  validates_attachment_size         :tsv, :less_than => 1.kilobyte
  validates :state, 
            :inclusion => { :in => [UPLOADED, IMPORTED] }
  
  ### PROCESSING ###
  
  after_create :create_parser_job

  def create_parser_job
    job = ImportParser.new(self.id)
    Delayed::Job.enqueue(job)
  end
  
  def imported?
    state == IMPORTED
  end
  
  def import!(total)
    update_attributes(:state => IMPORTED, :gross_revenue => total)
  end
  
  def file_data
    tsv.to_file || ''
  end
  
  protected
    
    def self.human_attribute_name(attribute, options={})
      HUMANIZED_COLUMNS[attribute.to_sym] || super
    end
  
end
