require "connect_four"
module Connect_Four
  describe Player do
    describe "#initialize" do
      context "when a new player is created" do
        it "captures Player's name" do
          me = Player.new("Cody", :red)
          expect(me.name).to eql("Cody")
        end
        it "captures Player's color" do
          me = Player.new("Cody", :red)
          expect(me.color).to eql(:red)
        end
      end
    end
  end
  describe Cell do
    describe "#initialize" do
      context "when a new cell is initialized" do
        it "is initialized as '' "do
          c = Cell.new
          expect(c.value).to eql('')
        end
        it "can be initialized with a value" do
          c = Cell.new(:black)
          expect(c.value).to eql(:black)
        end
      end
    end
  end
=begin
  describe Board do
    describe "#initialize" do
      context "when a new board is created" do
        it "is initialized with 7 columns and 6 rows" do
          b = Board.new
          expect(b.grid.size).to eql(6)
        end
      end
    end
  end
=end
end
