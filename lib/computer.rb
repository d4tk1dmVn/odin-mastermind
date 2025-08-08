require 'set'
require_relative 'knuth'
require_relative 'constants'

# Computer class
class Computer
  attr_accesor :possible_solutions
  attr_reader :notches, :all_solutions, :all_scores

  include Knuthable
  def initialize(notches)
    @notches = notches
    @all_solutions = Knuthable.generate_all_solutions
    @all_scores = Knuthable.generate_all_scores
    @possible_solutions = @all_solutions.dup
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

  def generate_guess_list(solution)
    guess_list = []
    Constants::ROWS.times do
      if guess_list.empty
        color_one = Constants::COLORS.keys[0]
        color_two = Constants::COLORS.keys[1]
        [color_one, color_one, color_two, color_two]
      else
        self.possible_solutions = Knuthable.purge_less_likely_solutions(possible_solutions, solution, guess_list[-1])
        current_unused_scores = Knuthable.minimax_step(all_solutions, all_scores, possible_solutions, guess_list)
        max_score_indices = Knuthable.calculate_max_score_indices(current_unused_scores)
        Knuthable.calculate_next_guess(all_solutions, possible_solutions, max_score_indices)
      end
    end
    guess_list
  end

  private

  def generate_hard_solution
    solution = []
    @notches.times do
      solution << Constants::COLORS.keys.sample
    end
    solution
  end
end
