class Comment < ApplicationRecord
  belongs_to :lecture, optional: true
  belongs_to :user, optional: true
end
