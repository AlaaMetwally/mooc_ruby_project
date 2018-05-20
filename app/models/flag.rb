class Flag < ApplicationRecord
    belongs_to :lecture, optional: true
end
