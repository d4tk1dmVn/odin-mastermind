# Computer class
class Computer
  attr_reader :name, :notches, :keys

  def initialize(notches, keys)
    @name = 'MASTERMINDINATOR 4000'
    @notches = notches
    @keys = keys
  end
end
