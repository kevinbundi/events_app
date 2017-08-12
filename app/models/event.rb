class Event < ActiveRecord::Base
  belongs_to :user
  has_many :user_events
  # users attending an instance of class Event
  has_many :events_attendees, through: :user_events, source: :user, dependent: :destroy
  has_many :comments, dependent: :destroy
  
  validates :name, :date, :location, :state, presence: true
  validate :future_date

  private
	def future_date
		if date.present? && date < Date.today
			errors.add(:date, "cannot be in the past")
		end
	end
end 

