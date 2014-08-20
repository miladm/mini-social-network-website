class AddPasswordToUsers < ActiveRecord::Migration
  def change
    add_column :users, :password_digest, :string
    add_column :users, :salt, :string

    # Initialization of each existing user password_digest and salt
    hasher = Digest::SHA2.new(bitlen = 512)
    User.reset_column_information
    @user_elems = User.find(:all)
    @user_elems.each() do |usr|
    	usr.salt = SecureRandom.hex(20).to_s
		pwd_salt = [usr.last_name.downcase,usr.salt].join()
		usr.password_digest = hasher.hexdigest(pwd_salt)
        usr.save()
    end
  end
end