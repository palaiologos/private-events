class Event < ActiveRecord::Base

  has_many :created_events, class_name: "Event", foreign_key: :creator_id
  has_many :attendees, through: :invites
  has_many :invites, through: :invites


  # Validations.
  validates :title, presence: true, length: { maximum: 50 }
  validates :location, presence: true
  validates :description, presence: true, length: { miminum: 30, maximum: 255 }
  validates :date, presence: true
  validates_uniqueness_of :date, scope: :creator_id, message: 'has already been taken by the current user, pick another date.'
  validate  :event_cant_be_in_the_past


  def event_cant_be_in_the_past
	  errors.add(:date, 'can\'t be in the past') if !date.blank? && date < Time.zone.today
  end
end
