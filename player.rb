class CoordinateDoesNotExist < StandardError
end

class AlreadyPlayed < StandardError
end

class NoAI < StandardError
end

class Game

# -------------------------------------------------------------
# Player class that is used to initialize player objects
# -------------------------------------------------------------

	class Player
		attr_accessor :name

		def initialize(name)
			@name = name
		end

		def win
			"\n\n#{@name} wins!\n"
		end
	end

# -------------------------------------------------------------
# Initializes the board
# Makes the player objects based on player input (names)
# Outputs the board
# Starts the game
# -------------------------------------------------------------

	def initialize
		make_board
		make_players
		puts @board
		start
	end

# -------------------------------------------------------------
# The start function that is used to play the actual game
# Documentation inside
# -------------------------------------------------------------

	def start
		puts "#{@players[0].name} is 'X'\t\t#{@players[1].name} is 'O'\n\n"
		p1turn = true # Used to check which player's turn it is. true = P1, false = P2 or AI
		while(1) # game loop, can only be broken out of if the win condition is met
			if p1turn == true
				p1turn = false
				begin
					print "[#{@players[0].name}'s turn] Enter a coordinate on the board to make your choice: "
					choice = gets.chomp
					raise CoordinateDoesNotExist unless @grid.has_key?(choice.to_sym) # Coordinate doesn't exist
					raise AlreadyPlayed unless @grid[choice.to_sym] == "null" # Coordinate has already been played
				rescue CoordinateDoesNotExist
					puts "Coordinate doesn't exist on the board. Please try again."
					retry
				rescue AlreadyPlayed
					puts "Cannot choose that space as that coordinate has already been played. Please try again."
					retry
				end
				@grid[choice.to_sym] = "X"
				@board.gsub!(choice.to_s, " X")
				puts @board
				if win? then break;
			end

			elsif (p1turn == false && @playercount.to_i == 2)
				p1turn = true
				begin
					print "[#{@players[1].name}'s turn] Enter a coordinate on the board to make your choice: "
					choice = gets.chomp
					raise CoordinateDoesNotExist unless @grid.has_key?(choice.to_sym) # See above
					raise AlreadyPlayed unless @grid[choice.to_sym] == "null" # See above
				rescue CoordinateDoesNotExist
					puts "Coordinate doesn't exist on the board. Please try again."
					retry
				rescue AlreadyPlayed
					puts "Cannot choose that space as that coordinate has already been played. Please try again."
					retry
				end
				@grid[choice.to_sym] = "O" 
				@board.gsub!(choice.to_s, " O")
				puts @board
				break if win?
			end
		end
		play_again
	end

	private

# -------------------------------------------------------------
# Initializes the board string and the grid hash
# -------------------------------------------------------------

	def make_board
		@board = "
		 a1 | a2 | a3
		--------------
		 b1 | b2 | b3 
		--------------
		 c1 | c2 | c3 
		"

		@grid = { a1: "null", a2: "null", a3: "null", 
							b1: "null", b2: "null", b3: "null", 
							c1: "null", c2: "null", c3: "null",
						}
	end

# -------------------------------------------------------------
# This function is used to create the player objects.
# -------------------------------------------------------------

	def make_players
		begin
			print "Type 1 to play against an AI, or type 2 to play with 2 Players: "
			@playercount = gets.chomp
			raise RuntimeError if @playercount.to_i.class.to_s != "Integer"
			raise RuntimeError if @playercount.to_i < 1 || @playercount.to_i > 2
			raise NoAI if @playercount.to_i == 1 # Temporary, will be removed when AI has been implemented
		rescue RuntimeError
			puts "Input must be a choice of 1 or 2. Please try again."
			retry
		rescue NoAI
			puts "This version does not have AI capabilities yet. Please pick choice 2."
			retry
		end
		@players = [] # Array used to store player objects

		for i in 0...@playercount.to_i
			print "Enter the name of Player#{i+1}: "
			name = gets.chomp
			if name == ""
				player = Player.new("Player#{i+1}")
			else
				player = Player.new(name)
			end
			@players << player
		end
	end

# -------------------------------------------------------------
# All the win conditions are checked against by using the grid
# hash
# -------------------------------------------------------------

	def win?
		if(@grid[:a1] == "X" && @grid[:a2] == "X" && @grid[:a3] == "X")
			puts @players[0].win
			return true
		elsif(@grid[:b1] == "X" && @grid[:b2] == "X" && @grid[:b3] == "X")
			puts @players[0].win
			return true
		elsif(@grid[:c1] == "X" && @grid[:c2] == "X" && @grid[:c3] == "X")
			puts @players[0].win
			return true
		elsif(@grid[:a1] == "X" && @grid[:b1] == "X" && @grid[:c1] == "X")
			puts @players[0].win
			return true
		elsif(@grid[:a2] == "X" && @grid[:b2] == "X" && @grid[:c2] == "X")
			puts @players[0].win
			return true
		elsif(@grid[:a3] == "X" && @grid[:b3] == "X" && @grid[:c3] == "X")
			puts @players[0].win
			return true
		elsif(@grid[:a1] == "X" && @grid[:b2] == "X" && @grid[:c3] == "X")
			puts @players[0].win
			return true
		elsif(@grid[:a3] == "X" && @grid[:b2] == "X" && @grid[:c1] == "X")
			puts @players[0].win
			return true

		elsif(@grid[:a1] == "O" && @grid[:a2] == "O" && @grid[:a3] == "O")
			puts @playercount.to_i == 2 ? @players[1].win : "\n\nAI wins!\n"
			return true
		elsif(@grid[:b1] == "O" && @grid[:b2] == "O" && @grid[:b3] == "O")
			puts @playercount.to_i == 2 ? @players[1].win : "\n\nAI wins!\n"
			return true
		elsif(@grid[:c1] == "O" && @grid[:c2] == "O" && @grid[:c3] == "O")
			puts @playercount.to_i == 2 ? @players[1].win : "\n\nAI wins!\n"
			return true
		elsif(@grid[:a1] == "O" && @grid[:b1] == "O" && @grid[:c1] == "O")
			puts @playercount.to_i == 2 ? @players[1].win : "\n\nAI wins!\n"
			return true
		elsif(@grid[:a2] == "O" && @grid[:b2] == "O" && @grid[:c2] == "O")
			puts @playercount.to_i == 2 ? @players[1].win : "\n\nAI wins!\n"
			return true
		elsif(@grid[:a3] == "O" && @grid[:b3] == "O" && @grid[:c3] == "O")
			puts @playercount.to_i == 2 ? @players[1].win : "\n\nAI wins!\n"
			return true
		elsif(@grid[:a1] == "O" && @grid[:b2] == "O" && @grid[:c3] == "O")
			puts @playercount.to_i == 2 ? @players[1].win : "\n\nAI wins!\n"
			return true
		elsif(@grid[:a3] == "O" && @grid[:b2] == "O" && @grid[:c1] == "O")
			puts @playercount.to_i == 2 ? @players[1].win : "\n\nAI wins!\n"
			return true
		elsif(!@grid.values.include?("null"))
			puts "\n\nIt's a draw!\n"
			return true
		end
	end

# -------------------------------------------------------------
# Used as the end game prompt to check whether the player
# wants to play again
# -------------------------------------------------------------

	def play_again
		begin		
			print "Would you like to play again?(Y/n): "
			choice = gets.chomp
			raise RuntimeError unless choice.to_s.downcase == "y" || choice.to_s.downcase == "n"
		rescue
			puts "Choice must be Y/n. Please try again"
			retry
		end

		if choice.downcase == "y"
			@players = []
			make_board
			make_players
			puts @board
			start
		else
			abort("Thank you for playing!")
		end
	end

end

game = Game.new