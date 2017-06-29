class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paperclip
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  ## Database authenticatable
  field :email,              type: String, default: ""
  field :encrypted_password, type: String, default: ""

  ## Recoverable
  field :reset_password_token,   type: String
  field :reset_password_sent_at, type: Time

  ## Rememberable
  field :remember_created_at, type: Time
  
  ## Trackable
  field :sign_in_count,      type: Integer, default: 0
  field :current_sign_in_at, type: Time
  field :last_sign_in_at,    type: Time
  field :current_sign_in_ip, type: String
  field :last_sign_in_ip,    type: String

  field :name, type: String
  field :membership, type: String
  field :civil_registry, type: String
  field :cpf, type: String
  field :birthday, type: String
  field :marital_status, type: String
  field :occupation, type: String
  field :address, type: String
  field :education_level, type: String
  field :accepted_terms, type: Mongoid::Boolean, default: false
  field :picture_file_name, type: String
  field :picture_file_size, type: String
  field :picture_content_type, type: String
  field :doc_front_file_name, type: String
  field :doc_front_file_size, type: String
  field :doc_front_content_type, type: String
  field :doc_back_file_name, type: String
  field :doc_back_file_size, type: String
  field :doc_back_content_type, type: String
  field :user_type, type: String, default: 'User'
  field :status, type: Integer, default: 0
  field :udid, type: String
  field :security_question, type: String
  field :security_answer, type: String
  
  has_mongoid_attached_file :picture, 
    :styles => { :medium => "320x320>", :thumb => "160x160#" },
    :storage        => :s3,
    :bucket_name    => 'TorcidaLegal',
    :bucket    => 'TorcidaLegal',
    :path           => ':attachment/:id/:style.:extension',
    :s3_credentials => File.join(Rails.root, 'config', 's3.yml')
  validates_attachment_size :picture, :less_than => 5.megabytes
  validates_attachment_content_type :picture, :content_type => ['image/jpeg', 'image/png', 'image/jpg']

  has_mongoid_attached_file :doc_front, 
    :styles => { :medium => "320x320>", :thumb => "160x160#" },
    :storage        => :s3,
    :bucket_name    => 'TorcidaLegal',
    :bucket    => 'TorcidaLegal',
    :path           => ':attachment/:id/:style.:extension',
    :s3_credentials => File.join(Rails.root, 'config', 's3.yml')
  validates_attachment_size :doc_front, :less_than => 5.megabytes
  validates_attachment_content_type :doc_front, :content_type => ['image/jpeg', 'image/png', 'image/jpg']

  has_mongoid_attached_file :doc_back, 
    :styles => { :medium => "320x320>", :thumb => "160x160#" },
    :storage        => :s3,
    :bucket_name    => 'TorcidaLegal',
    :bucket    => 'TorcidaLegal',
    :path           => ':attachment/:id/:style.:extension',
    :s3_credentials => File.join(Rails.root, 'config', 's3.yml')
  validates_attachment_size :doc_back, :less_than => 5.megabytes
  validates_attachment_content_type :doc_back, :content_type => ['image/jpeg', 'image/png', 'image/jpg']

  ## Confirmable
  # field :confirmation_token,   type: String
  # field :confirmed_at,         type: Time
  # field :confirmation_sent_at, type: Time
  # field :unconfirmed_email,    type: String # Only if using reconfirmable

  after_create :backlog
  belongs_to :torcida, optional: true

  def backlog
    Backlog.create(:description => self.name + ' realizou o cadastrou no aplicativo')
  end

  def self.mapuser (u)
    { :id => u.id.to_s, :name => u.name, :udid => u.udid, :status => u.status, :picture => u.picture, :doc_front => u.doc_front, :doc_back => u.doc_back, :membership => u.membership, :civil_registry => u.civil_registry, :cpf => u.cpf, :birthday => u.birthday, :marital_status => u.marital_status, :occupation => u.occupation, :address => u.address, :education_level => u.education_level, :accepted_terms => u.accepted_terms }
  end


  ## Lockable
  # field :failed_attempts, type: Integer, default: 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    type: String # Only if unlock strategy is :email or :both
  # field :locked_at,       type: Time
end
