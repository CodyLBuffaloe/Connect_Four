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
    def set_cell(x, y, value)
      get_cell(x, y).value = value
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
      puts "#{@player1.name}, please pick which row to drop your first piece: type a number, 1-7"
      this_move = gets.chomp
      x, y = translate_move_to_board(this_move)
      board.set_cell(x, y, @player1.color)
      board.display_formatted_grid
    end
    def translate_move_to_board(this_move)
      available_spaces = {
        "1" => [5,0],
        "2" => [5,1],
        "3" => [5,2],
        "4" => [5,3],
        "5" => [5,4],
        "6" => [5,5],
        "7" => [5,6]}
        available_spaces[this_move]
    end
  end
end

