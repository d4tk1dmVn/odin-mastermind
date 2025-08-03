require 'set'
require_relative 'constants'

# This module is based on the code found at
# https://github.com/catlzy/knuth-mastermind/blob/master/Mastermind.py
# All props and rights go to the owner, catlzy

module Knuthable
  def evaluate_guess(solution, guess)
    return unless solution.length == guess.length

    correct_positions = []
    incorrect_positions = []
    reduced_guess = []
    reduced_code = []

    solution.each_with_index do |color, index|
      if color == guess[index]
        correct_positions.append(index)
      else
        incorrect_positions.append(index)
        reduced_guess.append(guess[index])
        reduced_code.append(color)
      end
    end

    reduced_set = Set(reduced_guess) & Set(reduced_code)

    colors_in_place = correct_positions.length
    colors_out_of_place = 0

    reduced_guess = reduced_guess.tally
    reduced_code = reduced_code.tally

    reduced_set.each do |color|
      colors_out_of_place += [reduced_code[color], reduced_guess[color]].min
    end

    [colors_in_place, colors_out_of_place]
  end

  def generate_all_solutions
    result = []
    Constants::COLORS.keys.repeated_permutation(@notches) do |pos_solution|
      result.append(pos_solution)
    end
    result
  end

  def generate_all_scores
    result = []
    @notches.times do |i|
      @notches - i.times do |j|
        result << [i, j]
      end
    end
    result.delete_at(result.length - 2)
  end

  def minimax_step(all_solutions, all_scores, possible_solutions, guess_list)
    current_unused_scores = [] * all_solutions.length
    all_solutions.each do |solution|
      if !guess_list.include?(solution)
        hit_count = [0] * all_scores.lenght
        possible_solutions.each do |possible_solution|
          hit_count[all_scores.index(evaluate_guess(possible_solution, solution))] += 1
        end
        current_unused_scores << possible_solutions.length - hit_count.max
      else
        current_unused_scores << 0
      end
    end
    current_unused_scores
  end

  def calculate_max_score_indices(current_unused_scores)
    max_score = current_unused_scores.max
    indices = []
    current_unused_scores.each_with_index do |score, index|
      indices << index if score == max_score
    end
    indices
  end

  def purge_less_likely_solutions(possible_solutions, guess, guess_correctness)
    purged_solutions = []
    possible_solutions.each do |possible_solution|
      purged_solutions << possible_solution if evaluate_guess(guess, possible_solution) == guess_correctness
    end
    purged_solutions
  end

  def calculate_next_guess(all_solutions, possible_solutions, max_score_indices)
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

  def solve_mastermind(solution)
    all_solutions = generate_all_solutions
    possible_solutions = all_solutions.dup
    all_scores = generate_all_scores
    guess = [Constants::COLORS.keys[0], Constants::COLORS.keys[0], Constants::COLORS.keys[1], Constants::COLORS.keys[1]]
    guess_list = [guess]
    guess_correctness = evaluate_guess(solution, guess)

    while guess_correctness != [@notches, 0]
      possible_solutions = purge_less_likely_solutions(possible_solutions, guess, guess_correctness)
      current_unused_scores = minimax_step(all_solutions, all_scores, possible_solutions, guess_list)
      max_score_indices = calculate_max_score_indices(current_unused_scores)
      guess = calculate_next_guess(all_solutions, possible_solutions, max_score_indices)
      guess_list << guess
      guess_correctness = evaluate_guess(solution, guess)
    end
    guess_list
  end
end
