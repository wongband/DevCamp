class Portfolio < ApplicationRecord
	#Has to specifically say has_many if it is a one to many
	has_many :technologies, dependent: :destroy
	accepts_nested_attributes_for :technologies,
								   reject_if: lambda { |attrs| attrs["name"].blank? }

	include Placeholder
	#portfolios cannot be created unless they hve these parameters
	validates_presence_of :title, :body, :main_image, :thumb_image

	mount_uploader :thumb_image, PortfolioUploader
	mount_uploader :main_image, PortfolioUploader

	#allows you to separate routes by subtitle or in later cases, ids
	def self.react
		where(subtitle: "React")
	end

	def self.by_position
		order("position ASC")
	end

	scope :ruby, -> {where(subtitle: "Ruby on Rails")}

	#after the creation of the object if the fields are empty then call defaults
	after_initialize :set_defaults

	def set_defaults
		#self = this
		self.main_image ||= Placeholder.image_generator(height: "600", width: "400")
		self.thumb_image ||= Placeholder.image_generator(height: "350", width: "200")
	end
end
