version = "1.0.0"

puts "Welcome to Hangman #{version} - by Stefan ( Destroyergm )"
puts "You can same anytime by typing ~save in game"
puts "Action: "
puts "New Game [1]"
puts "Load Game [2]"
puts "Exit [3]"
print "Select action: "
input = gets.chomp.to_i
case input
when 1
	# Launch a new game
when 2
	# Load a game
when 3
	# Exit the application
else
	# Wrong input was parsed
end