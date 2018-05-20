class User < ApplicationRecord
  scope :recent, -> { where('created_at > ?', Time.now - (7*24*60*60)) }
  acts_as_voter
  extend Devise::Models
  include Genderize
  paginates_per 5
  attr_accessor :profile_picture
  validates :gender, :presence => true
  enum user_type: {admin: 0,instructor: 1,student: 2}
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }, :presence => true
  validates :name, :presence => true ,length: { minimum: 4 }
  validates_format_of :profile_picture, :with => %r{\.(png|jpg|jpeg|gif)\z}i, :message => "Not A Suitable ImageFormat"
  mount_uploader :profile_picture, ImageUploader
  genderize

  devise :registerable, :database_authenticatable, 
         :recoverable, :rememberable, :trackable, :validatable
    has_many :lectures
    has_many :courses
    has_many :comments, dependent: :destroy
end
