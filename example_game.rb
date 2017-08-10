require "./lib/connect_four.rb"

puts "Player 1, supply your name! You shall be Yellow!"
p1_name = gets.chomp
player1 = Connect_Four::Player.new({name: p1_name, color: :yellow})
puts "If there is another player, supply their name, otherwise the computer will destroy you\n ...in Connect Four. They will play as red."
p2_name = gets.chomp
if p2_name =~ /^[A-z]+$/
  player2 = Connect_Four::Player.new({name: p2_name, color: :red})
else
  puts "Hey, that isn't a name!"
end
players = [player1, player2]
Connect_Four::Game.new(players).play