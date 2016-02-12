class User < ActiveRecord::Base
  attr_accessor :remember_token

  # Associations.
  belongs_to :creator, class_name: "User"
  has_many :attended_events, through: :invites
  has_many :invites, foreign_key: :attendee_id

  # Callbacks


  # Validations
  validates :name, presence: true, length: { minimum: 5 , maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: 	true , length: { maximum: 255 },
        format: 	{ with: VALID_EMAIL_REGEX },
        uniqueness: { case_sensitive: false }




  # Generates digest for given string.
  def User.digest(string)
	  cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
												  BCrypt::Engine.cost
	  BCrypt::Password.create(string, cost: cost)
  end

  # Creates new token.
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # Remembers the given user.
  def remember
    self.remember_token = User.new_token
	  update_attribute(:remember_digest, User.digest(remember_token))
  end

  # True if the users remember_token matches.
  def authenticated?(token)
	  digest = self.remember_digest
	  return false if digest.nil?
	  BCrypt::Password.new(digest).is_password?(token)
  end

 # Forgets a user
  def forget
    update_attribute(:remember_digest, nil)
  end

  def upcoming_events
	  self.attended_events.to_a.select { |event| event.date > Time.zone.now }
  end

  def past_events
	  self.attended_events.to_a.select { |event| event.date < Time.zone.now }
  end















end
