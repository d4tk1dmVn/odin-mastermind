require_relative 'lib/board'
require_relative 'lib/player'
require_relative 'lib/player_input'
require_relative 'lib/constants'
require_relative 'lib/codemaker'
require_relative 'lib/codebreaker'
require_relative 'lib/output'

NOTCHES = Constants::NOTCHES
ROWS = Constants::ROWS
COLORS = Constants::COLORS

def end_of_game(board, codebreaker_mode, player, computer)
  puts Outputable.board_output(board.guesses.zip(board.hints))
  puts Outputable.solution_output(board.solution)
  if (codebreaker_mode && board.winner?) || (!codebreaker_mode && !board.winner?)
    puts "#{player.name} wins"
  else
    puts "#{computer.name} wins!"
  end
end

def codebreaker_mode(player)
  puts Constants::CODEBREAKER_MESSAGE
  computer = Codemaker.new(NOTCHES, COLORS.keys)
  solution = computer.generate_solution
  board = Board.new(ROWS, NOTCHES, solution)
  until board.winner? || board.full?
    candidate = PlayerInput.input_colors(COLORS, Outputable.color_prompt, NOTCHES)
    board.mark_row(candidate)
    puts Outputable.board_output(board.guesses.zip(board.hints))
  end
  end_of_game(board, true, player, computer)
end

def codemaker_mode(player)
  puts Constants::CODEMAKER_MESSAGE
  solution = PlayerInput.input_colors(COLORS, Outputable.color_prompt, NOTCHES)
  computer = Codebreaker.new(NOTCHES, COLORS.keys)
  board = Board.new(ROWS, NOTCHES, solution)
  until board.winner? || board.full?
    computer_guess = computer.generate_guess(solution, board.guesses)
    # The user can type stuff when this happens, could break stuff
    board.mark_row(computer_guess)
    puts Outputable.board_output(board.guesses.zip(board.hints))
  end
  end_of_game(board, false, player, computer)
end

def launch_game
  puts Outputable.game_title
  player = Player.new(PlayerInput.player_name)
  loop do
    codebreaker = PlayerInput.confirm('DO YOU WANT TO BE A CODEBREAKER (y) OR A CODEMAKER (n) ? Y/N')
    codebreaker ? codebreaker_mode(player) : codemaker_mode(player)
    break unless PlayerInput.confirm('DO YOU WANT A REMATCH? Y/N')
  end
  puts Outputable.exit_message
end

launch_game
