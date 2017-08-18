require "connect_four"
module Connect_Four
  describe Player do
    describe "#initialize" do
      context "when a new player is created" do
        it "captures Player's name" do
          me = Player.new({name: "Cody", color: :red})
          expect(me.name).to eql("Cody")
        end
        it "captures Player's color" do
          me = Player.new({name: "Cody", color: :red})
          expect(me.color).to eql(:red)
        end
      end
    end
  end

  describe Computer do
  end

  describe Board do
    describe "#initialize" do
      context "when a new board is created" do
        it "is initialized with 7 columns and 6 rows" do
          b = Board.new
          expect(b.grid.size).to eql(6)
        end
        it "creates six spaces in each row" do
          b = Board.new
          b.grid.each do |row|
            expect(row.size).to eql(7)
          end
        end
      end
    end
    describe "#get_cell" do
      context "when method recieves x and y values" do
        it "locates them within the grid" do
          b = Board.new
          b.grid[5][3] = "yellow"
          expect(b.get_cell(5, 3)).to eql("yellow")
        end
        it "locates a specific cell" do
          b = Board.new
          b.grid[5][3] = "yellow"
          expect(b.get_cell(5, 3)).to_not eql("_")
        end
        it "does not change the value of surrounding cells" do
          b = Board.new
          b.grid[5][3] = "red"
          expect(b.get_cell(0,3).value).to eql("_")
        end
      end
    end
  end

  describe Game do
    describe "#initialize" do
      context "when a new game is created" do
        it "creates a new Board" do
          g = Game.new
          expect(g.board).to_not eql(nil)
        end
        it "contains the player data" do
          players = [{"Cody" => :yellow}, {"Erick" => :red}]
          g = Game.new(players)
          expect(g.players.size).to eql(2)
        end
      end
    end
    describe "#translate_move_to_board" do
      context "when method receives move" do
        it "chooses column from hash" do
          g = Game.new
          t_m = "4"
          expect(g.translate_move_to_board(t_m)).to eql([[0,3], [1,3], [2,3], [3,3], [4,3], [5,3]])
        end
      end
    end
  end
end
