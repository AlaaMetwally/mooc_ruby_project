class Course < ApplicationRecord
    paginates_per 5
    has_many :lectures
    belongs_to :user, optional: true
    validates :title, :presence => true ,length: { minimum: 4 }
end 
