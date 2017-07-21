
module Connect_Four
  class Player
    attr_accessor :name, :color
    def initialize(name, color)
      @name = name
      @color = color
    end
  end
  class Cell
    attr_accessor :value
    def initialize(value = "")
      @value = value
    end
  end
=begin
  class Board
    attr_accessor :grid
    def initialze (grid = default_grid)
    end
    private
    def default_grid
      Array.new(7){Array.new(6)}
    end
  end
=end
end