class Torcida
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paperclip

  field :name, type: String
  field :picture_file_name, type: String
  field :picture_file_size, type: String
  field :picture_content_type, type: String
  field :active, type: Integer, default: 1

  belongs_to :clube
  has_many :users
  
  has_mongoid_attached_file :picture, 
    :styles => { :medium => "320x320>", :thumb => "160x160#" },
    :storage        => :s3,
    :bucket_name    => 'TorcidaLegal',
    :bucket    => 'TorcidaLegal',
    :path           => ':attachment/:id/:style.:extension',
    :s3_credentials => File.join(Rails.root, 'config', 's3.yml')
  validates_attachment_size :picture, :less_than => 5.megabytes
  validates_attachment_content_type :picture, :content_type => ['image/jpeg', 'image/png', 'image/jpg']

  def self.mapTorcida(c)
    arr = []
    c.each do |cu|
      arr <<  { :id => cu.id.to_s, :name => cu.name, :picture => cu.picture }
    end
    arr
  end

end
