require_relative 'knuth'

# Computer class
class Codebreaker < Computer
  attr_accessor :possible_solutions
  attr_reader :all_solutions, :all_scores

  include Knuthable
  def initialize(notches, keys)
    super
    @all_solutions = Knuthable.generate_all_solutions(notches, keys)
    @all_scores = Knuthable.generate_all_scores(notches)
    @possible_solutions = @all_solutions.dup
  end

  def generate_guess(solution, guesses)
    new_guess = []
    if guesses.empty?
      new_guess = [keys[0], keys[0], keys[1], keys[1]]
    else
      self.possible_solutions = Knuthable.purge_less_likely_solutions(possible_solutions, solution, guesses[-1])
      current_unused_scores = Knuthable.minimax_step(all_solutions, all_scores, possible_solutions, guesses)
      max_score_indices = Knuthable.calculate_max_score_indices(current_unused_scores)
      new_guess = Knuthable.calculate_next_guess(all_solutions, possible_solutions, max_score_indices)
    end
    new_guess
  end
end
