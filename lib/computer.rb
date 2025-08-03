require 'set'
require_relative 'knuth'

# Computer class
class Computer
  include Knuthable
  def initialize(notches)
    @notches = notches
  end

  def generate_solution(easy_mode)
    solution = []
    if easy_mode
      random_color_keys = Constants::COLORS.keys.shuffle
      random_chunk = random_color_keys[0...@notches]
      solution = random_chunk
    else
      solution = generate_hard_solution
    end
    solution
  end

  private

  def generate_hard_solution
    solution = []
    @notches.times do
      solution << Constants::COLORS.keys.sample
    end
    solution
  end

  def generate_guess_list(solution, difficulty)
    Knuthable.solve_mastermind(solution, difficulty)
  end
end
