class User <ActiveRecord::Base
	validates :username, presence: true, uniqueness: {case_sensitive: false}, length: {minimum: 3, maximum: 25}
	VALID_EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/
	validates :email, presence: true, uniqueness: {case_sensitive: false}, length: {minimum: 6, maximum: 80}, format: {with: VALID_EMAIL_REGEX}
end