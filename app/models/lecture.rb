class Lecture < ApplicationRecord
    acts_as_votable
    paginates_per 5
    belongs_to :course, optional: true
    validates :course_id, :presence => true
    belongs_to :user, optional: true
    has_many :flags
    has_many :comments, dependent: :destroy
    validates :content, :presence => true ,length: { minimum: 10 }
    validates :upload_file, :presence => true 
    validates_format_of :upload_file, :with => %r{\.(txt|ppt|pptx|pps|docx|doc|pdf|odt)\z}i, :message => "Not A Suitable FileFormat"
    mount_uploader :upload_file, FileUploader
end
