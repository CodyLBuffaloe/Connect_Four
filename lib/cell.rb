module Connect_Four
  class Cell
    attr_accessor :value
    def initialize(value = "_")
      @value = value
    end
  end
end