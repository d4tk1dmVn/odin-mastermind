require_relative 'lib/board'
require_relative 'lib/player'
require_relative 'lib/player_input'
require_relative 'lib/constants'
require_relative 'lib/computer'
require_relative 'lib/output'

NOTCHES = Constants::NOTCHES
ROWS = Constants::ROWS
COLORS = Constants::COLORS

def compute_win(player)
  player.win
  puts Outputable.win_output(player.name)
end

def codebreaker?
  [true, false].sample
end

def end_of_game(board, codemaker, codebreaker)
  puts Outputable.board_output(board.guesses.zip(board.hints))
  puts Outputable.solution_output(board.solution)
  board.winner? ? compute_win(codebreaker) : compute_win(codemaker)
end

def codebreaker_mode(player)
  puts "\n CODEBREAKER MODE \n"
  computer = Computer.new(NOTCHES, COLORS.keys)
  solution = computer.generate_solution
  board = Board.new(ROWS, NOTCHES, solution)
  until board.winner? || board.full?
    candidate = PlayerInput.input_colors(COLORS, Outputable.color_prompt, NOTCHES)
    board.mark_row(candidate)
    puts Outputable.board_output(board.guesses.zip(board.hints))
  end
  end_of_game(board, computer, player)
end

def codemaker_mode(player)
  puts "\n CODEMAKER MODE \n"
  solution = PlayerInput.input_colors(COLORS, Outputable.color_prompt, NOTCHES)
  computer = Computer.new(NOTCHES, COLORS.keys)
  board = Board.new(ROWS, NOTCHES, solution)
  until board.winner? || board.full?
    computer_guess = computer.generate_guess(solution, board.guesses)
    print(board.guesses.length)
    # The user can type stuff when this happens, could break stuff
    board.mark_row(computer_guess)
    puts Outputable.board_output(board.guesses.zip(board.hints))
  end
  end_of_game(board, computer, player)
end

def launch_game
  puts Outputable.game_title
  player = Player.new(PlayerInput.player_name)
  loop do
    codebreaker? ? codebreaker_mode(player) : codemaker_mode(player)
    break unless PlayerInput.confirm('DO YOU WANT A REMATCH? Y/N')
  end
  puts Outputable.exit_message
end

launch_game
