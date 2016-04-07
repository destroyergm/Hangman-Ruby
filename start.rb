require ("./lib/game.rb")

version = "1.0.0"

puts "Welcome to Hangman #{version} - by Stefan ( Destroyergm )"
puts "You can save anytime by typing ~ in game"
puts "Action: "
puts "New Game [1]"
puts "Load Game [2]"
puts "Exit [3]"
print "Select action: "
input = gets.chomp.to_i
case input
when 1
	# Launch a new game
	Game.new
when 2
	# Load a game
	Game.load_from_file
when 3
	# Exit the application
	exit
else
	# Wrong input was parsed
	puts "Invalid argument error."
end