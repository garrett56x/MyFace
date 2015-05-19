class User < ActiveRecord::Base
	has_many :posts
	has_attached_file :profile_pic
	has_many :invitations
	has_many :friendships
	has_many :friends, through: :friendships

	attr_accessor :password, :password_confirmation

	EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i

	validates :first_name, :last_name, presence: true
	validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: EMAIL_REGEX }
	validates :password, presence: true, length: { minimum: 7 }, confirmation: true,
			  if: Proc.new { |a| a.encrypted_password.blank? }
	validates :password_confirmation, presence: true,
			  if: Proc.new { |a| a.encrypted_password.blank? }
	validates_attachment_content_type :profile_pic,
									  :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

	before_save :encrypt_password,
				if: Proc.new { |a| a.encrypted_password.blank? }

	def has_password?(submitted_password)
		self.encrypted_password == encrypt(submitted_password)
	end

	def self.authenticate(email, submitted_password)
		user = User.find_by email: email
		return nil if user.nil?
		return user if user.has_password?(submitted_password)
	end

	private
		def encrypt_password
			self.salt = Digest::SHA2.hexdigest("#{Time.now.utc}--#{self.password}") if self.new_record?
			self.encrypted_password = encrypt(self.password)
		end

		def encrypt(pass)
			Digest::SHA2.hexdigest("#{self.salt}--#{pass}")
		end
end
