require 'set'

# This module is based on the code found at
# https://github.com/catlzy/knuth-mastermind/blob/master/Mastermind.py
# All props and rights go to the owner, catlzy

module Knuthable
  def self.random_boolean?
    [true, false, false, false].sample
  end

  def self.random_integer
    [0, 1, -1].sample
  end

  def self.generate_all_solutions(notches, keys)
    result = []
    keys.repeated_permutation(notches) do |pos_solution|
      result.append(pos_solution)
    end
    result
  end

  def self.generate_all_scores(notches)
    result = []
    (notches + 1).times do |i|
      (notches - i + 1).times do |j|
        result << [i, j]
      end
    end
    result.delete_at(result.length - 2)
    result
  end

  def self.evaluate_guess(solution, guess)
    return unless solution.length == guess.length

    correct_positions = []
    reduced_guess = []
    reduced_code = []

    solution.each_with_index do |color, index|
      if color == guess[index]
        correct_positions.append(index)
      else
        reduced_guess.append(guess[index])
        reduced_code.append(color)
      end
    end

    reduced_set = Set.new(reduced_guess) & Set.new(reduced_code)

    colors_in_place = correct_positions.length
    colors_out_of_place = 0

    reduced_guess = reduced_guess.tally
    reduced_code = reduced_code.tally

    reduced_set.each do |color|
      colors_out_of_place += [reduced_code[color], reduced_guess[color]].min
    end

    [colors_in_place, colors_out_of_place]
  end

  def self.calculate_max_hit_count(solution, possible_solutions, all_scores)
    hit_count = [0] * all_scores.length
    possible_solutions.each do |possible_solution|
      possible_solution_score = evaluate_guess(possible_solution, solution)
      index = all_scores.index(possible_solution_score)
      hit_count[index] += 1
    end
    hit_count.max
  end

  def self.leveled_unused_score(proper_result)
    altered_result = proper_result + random_integer
    random_boolean? && altered_result.positive? ? altered_result : proper_result
  end

  def self.minimax_step(all_solutions, all_scores, possible_solutions, guess_list)
    current_unused_scores = [] * all_solutions.length
    all_solutions.each do |solution|
      if !guess_list.include?(solution)
        max_hint_count = calculate_max_hit_count(solution, possible_solutions, all_scores)
        current_unused_scores << leveled_unused_score(possible_solutions.length - max_hint_count)
      else
        current_unused_scores << 0
      end
    end
    current_unused_scores
  end

  def self.calculate_max_score_indices(current_unused_scores)
    max_score = current_unused_scores.max
    indices = []
    current_unused_scores.each_with_index do |score, index|
      indices << index if score == max_score
    end
    indices
  end

  def self.should_be_added?(must_be_added)
    return true if must_be_added

    random_boolean?
  end

  def self.purge_less_likely_solutions(possible_solutions, solution, guess)
    guess_correctness = evaluate_guess(solution, guess)
    purged_solutions = []
    possible_solutions.each do |possible_solution|
      must_be_added = evaluate_guess(guess, possible_solution) == guess_correctness
      purged_solutions << possible_solution if should_be_added?(must_be_added)
    end
    purged_solutions
  end

  def self.calculate_next_guess(all_solutions, possible_solutions, max_score_indices)
    result = []
    change = false
    max_score_indices.each do |index|
      next unless possible_solutions.include?(all_solutions[index])

      result = all_solutions[index]
      change = true
      break
    end
    result = all_solutions[max_score_indices[0]] unless change
    result
  end
end
