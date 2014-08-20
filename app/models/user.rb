class User < ActiveRecord::Base
	has_many	:photos
	has_many	:comments
	has_many	:tags

	validates :first_name, presence: true
	validates :last_name, presence: true
	validates :login, presence: true

	def full_name
		"#{first_name} #{last_name}"
	end

	def full_name=(name)
		first_name, last_name = name.split
	end

	def password_valid? (input_pwd)
		hasher = Digest::SHA2.new(bitlen = 512)
		db_pwd_digest 	= self.password_digest
		input_pwd_salt 	= [input_pwd,self.salt].join()
		input_pwd_digest = hasher.hexdigest(input_pwd_salt)

		if input_pwd_digest .eql? db_pwd_digest then
			return true
		else
			return false
		end
	end

	def password
		return @password
	end

	def password=(pwd)
		hasher = Digest::SHA2.new(bitlen = 512)
		salt = SecureRandom.hex(20)
		self.salt = salt
		pwd_salt  = [pwd,self.salt].join()
		self.password_digest = hasher.hexdigest(pwd_salt)
	end
end
