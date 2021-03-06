class Restaurant < ActiveRecord::Base
	has_many :menu_items
	has_many :checks
	has_many :diners, through: :checks 
	# has_many :users, through: :checks

	belongs_to :owner, class_name: "User"

	validates :name, :address, :description, :presence => true
end

