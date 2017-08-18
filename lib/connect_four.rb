require_relative "cell"
module Connect_Four
  class Player
    attr_accessor :name, :color
    def initialize(input) #holds value of Player name and color
      @name = input.fetch(:name)
      @color = input.fetch(:color)
    end
  end

  class Computer
    def initialize

    end
  end

  class Board
    attr_accessor :grid
    def initialize(input = {}) #fetches grid from #default_grid or builds grid from supplied data
      @grid = input.fetch(:grid, default_grid)
    end
    def get_cell(x, y)
      grid[x][y]
    end
    def set_cell(column, value)
      color = value.to_s
      inverted_column = column.reverse!
      inverted_column.each do |space|
        x, y = space
        open_space = get_cell(x, y).value
        if open_space == "_"
          open_space = color
        else
          inverted_column.pop(space)
        end
      end
    end
    def display_formatted_grid #builds and displays formatted 6x7 empty grid or grid w/values of cells
      grid.each do |row|
        puts row.map{|cell| cell.value.empty? ? "_" : cell.value}.join(" ")
      end
    end
    def default_grid #builds 2D Array of Cell objects to initialize grid
      Array.new(6){Array.new(7) {Cell.new}}
    end
  end

  class Game
    attr_accessor :board, :players
    def initialize(players= ["Cody"]) #initiates a new board and accepts an Array of player hashes
      @board = Board.new
      @players = players
      @player1 = players[0]
      @player2 = players[1]
    end
    def play
      puts "#{@player1.name}, please pick which column to drop your first piece: type a number, 1-7"
      board.display_formatted_grid
      this_move = gets.chomp
      column = translate_move_to_board(this_move)
      board.set_cell(column, @player1.color)
      board.display_formatted_grid
      puts "#{@player2.name}, now it is your turn! 1-7!"
      next_move = gets.chomp
      column = translate_move_to_board(next_move)
      board.set_cell(column, @player2.color)
      board.display_formatted_grid
    end
    def translate_move_to_board(this_move) #selects a column to evaluate
      available_spaces = {
        "1" => [[0,0], [1,0], [2,0], [3,0], [4,0], [5,0]],
        "2" => [[0,1], [1,1], [2,1], [3,1], [4,1], [5,1]],
        "3" => [[0,2], [1,2], [2,2], [3,2], [4,2], [5,2]],
        "4" => [[0,3], [1,3], [2,3], [3,3], [4,3], [5,3]],
        "5" => [[0,4], [1,4], [2,4], [3,4], [4,4], [5,4]],
        "6" => [[0,5], [1,5], [2,5], [3,5], [4,5], [5,5]],
        "7" => [[0,6], [1,6], [2,6], [3,6], [4,6], [5,6]]
        }
        available_spaces[this_move]
    end
  end
end

