class Interview < ApplicationRecord
	
	validates :startTime, presence: true
	validates :endTime, presence: true
	validate :endTime_cannot_be_in_the_past
	validate :startTime_cannot_be_in_the_past
	validate :endTime_startTime_comparison
	validate :number_of_participants
	validate :participants_free

    def endTime_cannot_be_in_the_past
      if (endTime.present? && endTime.past?)
        errors.add( :endTime, "can't be in the past")
      end
    end

    def startTime_cannot_be_in_the_past
      if (startTime.present? && startTime.past?)
        errors.add( :startTime, "can't be in the past")
      end
    end
 
 	def endTime_startTime_comparison
      if (endTime.present? && startTime.present? && endTime<startTime)
        errors.add( :endTime, "can't be before start Time")
      end
    end

    def number_of_participants
      errors.add(:interview, "participants count should be more than 1") if self.users.size < 2
    end
	
	def participants_free
	  self.users.each do |user|
	  	user.interviews.each do |inter|
	  	  unless (inter.endTime<=self.startTime || self.endTime<=inter.startTime)
	  	  	if self.id!=inter.id
	  	      errors.add(:interview, "participant is not available in given slot") 
	        end
	      end
	    end
	  end
	end

	has_and_belongs_to_many :users

end

