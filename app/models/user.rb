class User < ApplicationRecord
	validates :email, uniqueness: true
	has_and_belongs_to_many :interviews
end
