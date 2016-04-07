class Letter
	attr_accessor :visible
	attr_reader :letter

	def initialize(letter)
		@letter = letter
		@visible = false
	end
end