require("./lib/letter.rb")
require("yaml")

class Game
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
		@visible = []
 

	 	# Initialize each letter to hidden
		@choosen.each_char do |letter|
			@visible << Letter.new(letter)
		end

		start
	end

	def self.load_from_file
		obj = nil
		File.open("saves/save.yaml","r") do |file|
			obj = file.readlines
		end
		# initialize the game instance from a file
		game_instance = YAML::load(obj.join)
		# start the game instance
		game_instance.start
	end

	def start
		# Game Loop
		loop do
		@playing = true
			# Stop the game when all visible
			if @visible.all? {|let| let.visible == true}
				@playing = false
			end

			# render a invisible word / woord to guess
			render

			# Game over condtions
			break unless @playing
			break if @lives == 0
			user_input
			puts @visible
		end

		# game over
		if @lives == 0
			game_over
		else
			# win
			win
		end
	end

	private
	def render
		system "clear"
		puts "You have #{@lives} lives left." 
		@visible.each do |letter|
			print "_ " unless letter.visible
			print "#{letter.letter} " if letter.visible
		end
		puts
	end

	def user_input
		# Repeat untill valid input
		print "Guess a letter: "
		until (input = gets.chomp) =~ /[a-z]|[A-Z]/ do
			# save special character
			if(input == "~") 
				# Save game
				object = YAML::dump(self);
				puts "Saved!"
				File.open("saves/save.yaml","w") do |file|
					file.write object 
					file.close
				end
				# exit program
				exit
			end
			print "Wrong input, enter again: "
		end
		# Show the word that is guessed
		found = false
		@visible.each_with_index do |let,index|
			if let.letter.downcase == input.downcase
				@visible[index].visible = true
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
		puts "Thanks for playing :)"
	end

	def game_over
		puts "Thanks for playing"
		puts "You lose! The word was #{@choosen}"
	end
end
