require_relative "cell"
module Connect_Four
  class Player
    attr_accessor :name, :color
    def initialize(input) #holds value of Player name and color
      @name = input.fetch(:name)
      @color = input.fetch(:color)
    end
  end
  class Board
    attr_accessor :grid
    def initialize(input = {}) #fetches grid from #default_grid or builds grid from supplied data
      @grid = input.fetch(:grid, default_grid)
    end
    def get_cell(x, y) #retrieves the Cell object from @grid
      grid[x][y]
    end
    def set_cell(column, value) #reverses coloumn, calls #get_cell, if cell value is "_", replace w/player color
      color = value
      inverted_column = column.reverse!
      inverted_column.each do |space|
        x, y = space
        open_space = get_cell(x, y).value
        if open_space == "_"
          return get_cell(x, y).value = color
        end
      end
    end
    def find_diagonals(value_rows) #searches for diagonal wins
      yellow_count = 0
      red_count = 0
      value_rows.each_with_index do |row, y|
        row.each_with_index do |cell, x|
          if cell == :Y
            yellow_count += 1
            if cell == value_rows[(y + 1)][(x + 1)]
              yellow_count += 1
              red_count = 0
              if cell == value_rows[(y + 2)][(x + 2)]
                yellow_count += 1
                red_count = 0
                if cell == value_rows[(y + 3)][(x + 3)]
                  yellow_count += 1
                  red_count = 0
                  return "Y"
                end
              end
            end
            if cell == value_rows[(y - 1)][(x + 1)]
              yellow_count += 1
              red_count = 0
              if cell == value_rows[(y - 2)][(x + 2)]
                yellow_count += 1
                red_count = 0
                if cell == value_rows[(y - 3)][(x + 3)]
                  yellow_count += 1
                  red_count = 0
                  return "Y"
                end
              end
            end
          elsif cell == "_"
            yellow_count = 0
            red_count = 0
          end
          if cell == :R
            red_count += 1
            yellow_count = 0
            if cell == value_rows[(y + 1)][(x + 1)]
              red_count += 1
              yellow_count = 0
              if cell == value_rows[(y + 2)][(x + 2)]
                red_count += 1
                yellow_count = 0
                if cell == value_rows[(y + 3)][(x + 3)]
                  red_count += 1
                  yellow_count = 0
                  return "R"
                end
              end
            end
            if cell == value_rows[(y - 1)][(x + 1)]
              red_count += 1
              yellow_count = 0
              if cell == value_rows[(y - 2)][(x + 2)]
                red_count += 1
                yellow_count = 0
                if cell == value_rows[(y - 3)][(x + 3)]
                  red_count += 1
                  yellow_count = 0
                  return "R"
                end
              end
            end
          elsif cell == "_"
            yellow_count = 0
            red_count = 0
          end
        end
      end
      if yellow_count == 4
        return "Y"
      end
      if red_count == 4
        return "R"
      end
    end
    def chip_count (value_rows) #finds horizontal and vertical wins, sends value_rows to find_diagonals
      yellow_count = 0
      red_count = 0
      value_rows.reverse.each do |row|
        next if row.count("_") == 7
        if row.size == 6 && row.count("_") == 6
          next
        end
          row.each do |cell|
            if cell == :Y || cell == :R
              if cell == :Y
                yellow_count += 1
                red_count = 0
                if yellow_count == 4
                  return "Y"
                end
              end
              if cell == :R
                red_count += 1
                yellow_count = 0
                if red_count == 4
                  return "R"
                end
              end
            elsif cell == "_"
              yellow_count = 0
              red_count = 0
            end
          end
        yellow_count = 0
        red_count = 0
      end
      find_diagonals(value_rows)
      if find_diagonals(value_rows) == "Y"
        return "Y"
      elsif find_diagonals(value_rows) == "R"
        return "R"
      end
    end
    def winner? #returns true if game is won, false if not
      value_rows = []
      winning_moves.each do |moveset|
        value_rows << extract_winning_values(moveset)
      end
      chip_count(value_rows)
        if chip_count(value_rows) == "Y" || chip_count(value_rows) == "R"
          return true
        else
          return false
        end
    end
    def extract_winning_values(winning_moves) #locates the value in each Cell object
      winning_moves.map{|cell| cell.value}
    end
    def winning_moves #currently set so that the columns and rows(transpose) will be available
      grid + grid.transpose
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
      @player1 = @players[0]
      @player2 = @players[1]
    end
    def play #plays the game
      guesses = 0
      while true
        if guesses.even?
          current_player = @player1
        else
          current_player = @player2
        end
        puts "#{current_player.name}, please pick which column to drop your first piece: type a number, 1-7"
        board.display_formatted_grid
        this_move = gets.chomp
        column = translate_move_to_board(this_move)
        board.set_cell(column, current_player.color)
        board.display_formatted_grid
        if guesses >= 6
          if board.winner?
            puts "Congrats, #{current_player.name}, you won! Yay!"
            return false
          end
        end
        guesses += 1
      end
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