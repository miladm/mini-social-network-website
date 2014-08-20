class Photo < ActiveRecord::Base
	belongs_to	:user
	has_many 	:comments
	has_many	:tags

	validates :user_id, presence: true
	validates :date_time, presence: true
	validates :file_name, presence: true
end