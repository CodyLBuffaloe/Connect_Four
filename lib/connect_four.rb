require "cell.rb"
module Connect_Four
  class Player
    attr_accessor :name, :color
    def initialize(name, color)
      @name = name
      @color = color
    end
  end

  class Board
    attr_accessor :grid
    def initialize(input = {})
      @grid = input.fetch(:grid, default_grid)
    end
    def default_grid
      Array.new(7){Array.new(6) {Cell.new}}
    end
  end

end