class Tag < ActiveRecord::Base
	belongs_to	:user
	belongs_to	:photo

	validates :user_id, presence: true
	validates :photo_id, presence: true
	validates :top, presence: true
	validates :left, presence: true
	validates :width, presence: true
	validates :height, presence: true
	validates :date_time, presence: true
end