# Player class
class Player
  attr_reader :name, :wins

  def initialize(name)
    @name = name
    @wins = 0
  end

  def gloat
    puts "#{name} WINS!!!!"
    concede_win
  end

  private

  def concede_win
    @wins += 1
  end
end
