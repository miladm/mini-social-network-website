class AddLoginToUsers < ActiveRecord::Migration
  def change
    add_column :users, :login, :string
    
    # Initialization of each existing user to lowecase of last_name
    User.reset_column_information
    @user_elems = User.find(:all)
    @user_elems.each() do |usr|
    	usr.login = usr.last_name.downcase
    	usr.save()
    end
  end
end
