require_relative 'lib/board'
require_relative 'lib/player'
require_relative 'lib/player_input'
require_relative 'lib/constants'
require_relative 'lib/computer'
require_relative 'lib/output'

def compute_win(player)
  player.win
  puts Outputable.win_output(player.name)
end

def end_of_game(board, codemaker, codebreaker)
  puts Outputable.board_output(board.guesses.zip(board.hints))
  puts Outputable.solution_output(board.solution)
  board.winner? ? compute_win(codebreaker) : compute_win(codemaker)
end

def arun_game(player)
  computer = Computer.new(Constants::NOTCHES)
  colors = computer.generate_solution(true)
  board = Board.new(Constants::ROWS, Constants::NOTCHES, colors)
  until board.winner? || board.full?
    candidate = PlayerInput.input_colors(Constants::COLORS, Outputable.color_prompt, Constants::NOTCHES)
    board.mark_row(candidate)
    puts Outputable.board_output(board.guesses.zip(board.hints))
  end
  end_of_game(board, computer, player)
end

def run_game(player)
  computer = Computer.new(Constants::NOTCHES)
  solution = PlayerInput.input_colors(Constants::COLORS, Outputable.color_prompt, Constants::NOTCHES)
  computer_guesses = computer.generate_guess_list(solution).take(Constants::ROWS).reverse
  board = Board.new(Constants::ROWS, Constants::NOTCHES, solution)
  until board.winner? || board.full?
    board.mark_row(computer_guesses.pop)
    puts Outputable.board_output(board.guesses.zip(board.hints))
  end
  end_of_game(board, computer, player)
end

def launch_game
  puts Outputable.game_title
  player = Player.new(PlayerInput.player_name)
  loop do
    run_game(player)
    break unless PlayerInput.confirm('DO YOU WANT A REMATCH? Y/N')
  end
  puts Outputable.exit_message
end

launch_game
