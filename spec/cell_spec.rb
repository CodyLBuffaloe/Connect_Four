require "./lib/cell.rb"
module Connect_Four
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
end