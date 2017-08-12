class User < ActiveRecord::Base
  has_secure_password
  # events created by user
  has_many :events, dependent: :destroy
  #the association by which to enable us to get data for the method 'events_attendings' below
  has_many :user_events
  #events attended by instances of class User
  has_many :events_attendings, through: :user_events, source: :event
  has_many :comments, dependent: :destroy 

  validates :first_name, :last_name, :email, :location, :state, presence: true, length: {in: 1..256}
  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  validates :email, uniqueness: {case_sensitive: false}, format: {with: EMAIL_REGEX}
  before_save do
  	self.email.downcase!
  	self.first_name.capitalize!
  	self.last_name.capitalize!
  	self.location.capitalize!
  end
  def full_name
    self.first_name + ' ' + self.last_name
  end
end
