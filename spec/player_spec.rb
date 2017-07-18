require "spec_helper"

module Connect_Four
  describe Player do
    describe "#initialize" do
      context "when new player is initialized" do
        it "assigns name and color to player" do
          input = {name: "Cody", color: "red"}
          expect {Player.new(input)}.to_not raise_error
        end
      end
    end
  end
end