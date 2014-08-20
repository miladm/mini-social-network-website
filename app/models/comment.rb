class Comment < ActiveRecord::Base
	belongs_to	:user
	belongs_to	:photo

	validates :photo_id, presence: true
	validates :user_id, presence: true
	validates :date_time, presence: true
	validates :comment, presence: true
end