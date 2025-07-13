require_relative 'lib/board'
require_relative 'lib/player'
require_relative 'lib/player_input'
require_relative 'lib/constants'
require_relative 'lib/computer'

=begin
def game_over?(board, marker_one, marker_two)
    board.check_winner == marker_one || board.check_winner == marker_two || board.no_winner?
end

def valid_coordinates?(board, coordinates)
    coordinates != nil && board.free_square?(*coordinates)
end

 

def display_result (players, board)

    players[0].gloat if players[0].marker == board.check_winner

    players[1].gloat if players[1].marker == board.check_winner

    puts "IT'S A TIE!" if board.no_winner?

end

 

def show_scores(players)

    if players[0].wins == players[1].wins

        puts "SO FAR BOTH PLAYERS ARE TIED!!!!"

    else

        winner, loser = players[0].wins > players[1].wins ? players : players.reverse

        puts "SO FAR #{winner.name} IS AHEAD OF #{loser.name} #{winner.wins} TO #{loser.wins}"

    end

end

 
=end

def run_game(player)
  computer = Computer.new(Constants::NOTCHES)
  colors = computer.generate_solution(true)
  board = Board.new(Constants::ROWS, Constants::NOTCHES, colors)
  puts board.printable_board
  until board.winner? || board.full?
    candidate = PlayerInput.input_colors(Constants::COLORS, Constants::COLOR_PROMPT, Constants::NOTCHES)
    board.mark_row(candidate)
    puts board.printable_board
  end
  player.gloat if board.winner?
  puts board.printable_solution
end

def launch_game
  puts Constants::SEPARATOR
  puts Constants::TITLE
  puts Constants::SEPARATOR
  player = Player.new(PlayerInput.player_name)
  loop do
    run_game(player)
    break unless PlayerInput.confirm('DO YOU WANT A REMATCH? Y/N')
  end
  puts "BYE!\n\n\n"
end

launch_game
