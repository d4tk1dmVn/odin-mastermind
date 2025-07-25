require_relative 'constants'

module Outputable
  def self.colorize(color_key, text)
    escape_code = Constants::ANSI_ESCAPING[color_key]
    prefix = "\033[38;5;#{escape_code}m"
    suffix = "\033[0m"
    "#{prefix}#{text}#{suffix}"
  end

  def self.color_prompt
    prompt_text = ''
    Constants::COLORS.each do |color_key, color_name|
      prompt_chunk = "(#{color_name[0]})#{color_name[1..]}"
      colorized_prompt_color = colorize(color_key, prompt_chunk.downcase)
      prompt_text += "#{colorized_prompt_color}\n"
    end
    "\n\n#{prompt_text}\n\n"
  end

  def self.create_color_row(row, text_source)
    colorized_array = row.map do |key|
      colorize(key, text_source[key])
    end
    colorized_array.join(' ')
  end

  def self.hint_output(hint)
    create_color_row(hint, Constants::HINTS)
  end

  def self.guess_output(guess)
    create_color_row(guess, Constants::COLORS)
  end

  def self.calculate_blank_spaces(unescaped_guess)
    guesses_length = unescaped_guess.map do |guess_key|
      Constants::COLORS[guess_key]
    end.join(' ').length
    ' ' * (Constants::MAX_ROW_LENGTH / 2 - guesses_length)
  end

  def self.row_output(guess_and_hint)
    blank_spaces = calculate_blank_spaces(guess_and_hint[0])
    colorized_guess = guess_output(guess_and_hint[0])
    colorized_hint = hint_output(guess_and_hint[1])
    "#{colorized_guess}#{blank_spaces}#{colorized_hint}\n"
  end

  def self.board_output(zipped_board)
    result = ''
    zipped_board.each do |guess_and_hint|
      result += row_output(guess_and_hint)
    end
    "\n\n#{result}\n\n"
  end

  def self.solution_output(solution)
    colorized_solution = create_color_row(solution, Constants::COLORS)
    "\n\n#{colorized_solution}\n\n"
  end
end
