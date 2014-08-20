class CreateTags < ActiveRecord::Migration
  	def change
	    create_table :tags do |t|
			t.integer	:photo_id
			t.integer	:user_id
	    	t.integer	:top
	    	t.integer	:left
	    	t.integer	:width
	    	t.integer	:height
	    	t.datetime	:date_time

			t.timestamps
	    end
  	end
end