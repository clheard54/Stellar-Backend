class Calendar < ApplicationRecord
    belongs_to :user
    has_many :events
    accepts_nested_attributes_for :events

    
end
