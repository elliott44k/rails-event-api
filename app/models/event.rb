class Event < ApplicationRecord
    belongs_to :user
    validates :name, :location, :start_time, :end_time, :user_id, presence: true
end
