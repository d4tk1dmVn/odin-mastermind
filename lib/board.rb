# Board class
class Board
  attr_reader :guesses, :hints

  def initialize(rows, notches, solution)
    @rows = rows
    @notches = notches
    @solution = solution
    @guesses = []
    @hints = []
  end

  def solution
    return @solution if winner? || full?

    []
  end

  def mark_row(guess)
    return if full?

    @hints << calculate_hint(guess)
    guesses << guess
  end

  def winner?
    !guesses.empty? && @solution == guesses[-1]
  end

  def full?
    guesses.length == @rows
  end

  private

  def aggregate_correct_hints(guess, gue_hash, sol_hash, cur_hint)
    guess.each_with_index do |color, index|
      if color == @solution[index]
        cur_hint << :correct
      else
        gue_hash[color] += 1
        sol_hash[@solution[index]] += 1
      end
    end
  end

  def aggregate_almost_hints(gue_hash, sol_hash, cur_hint)
    gue_hash.each_key do |guess_color|
      hints_per_color = [gue_hash[guess_color], sol_hash[guess_color]].min
      hints_per_color.times { cur_hint << :almost }
    end
  end

  def aggregate_incorrect_hints(incorrect_hints_amount, current_hint)
    incorrect_hints_amount.times { current_hint << :incorrect }
  end

  def calculate_hint(guess)
    solution_hash = Hash.new(0)
    guess_hash = Hash.new(0)
    current_hint = []
    aggregate_correct_hints(guess, guess_hash, solution_hash, current_hint)
    aggregate_almost_hints(guess_hash, solution_hash, current_hint)
    incorrect_hints_amount = guess.length - current_hint.length
    aggregate_incorrect_hints(incorrect_hints_amount, current_hint)
    current_hint
  end
end
