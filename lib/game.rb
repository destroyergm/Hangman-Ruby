class Game
	attr_accessor :visible, :choosen, :playing, :lives

	def initialize
		load_dictionary

		# 0 -3 to remove end characters
		@choosen = @words.sample[0..-3]

		# Words array is no longer needed, get it back to nil
		# To save memory on serialization
		@words = nil

		# You start the game with 10 lives
		@lives = 10

		# Visible words hash
		@visible = {}

		puts @choosen
		start
	end

	def start
		# Initialize each letter to hash
		@choosen.each_char do |letter|
			@visible[letter]  = false
		end

		# Game Loop
		loop do
		@playing = true
			# Stop the game when all visible
			if @visible.values.all? {|i| i == true}
				@playing = false
			end

			# render a invisible word / woord to guess
			render

			# Game over condtions
			break unless @playing
			break if @lvies == 0
			user_input
			puts @visible
		end

		# game over
		if lives == 0
			game_over
		else
			# win
			win
		end
	end

	private
	def render
		puts "You have #{@lives} lives left." 
		@visible.each do |letter,visible|
			print "_ " unless visible
			print "#{letter} " if visible
		end
		puts
	end

	def user_input
		# Repeat untill valid input
		until (input = gets.chomp) =~ /[a-z]|[A-Z]/ do
			print "Wrong input, enter again: "
		end
		# Show the word that is guessed
		found = false
		@visible.each do |letter,visible|
			if letter.downcase == input.downcase
				@visible[letter] = true
				found = true
			end
		end
		@lives -= 1 if !found
	end

	# load the dictionary list
	def load_dictionary
		@words = []
		File.open("words/5desk.txt", "r") do | file |
			@words = file.readlines
			file.close
		end	
	end

	def win
	end

	def game_over
	end
end

Game.new