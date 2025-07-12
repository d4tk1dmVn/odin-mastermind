require_relative 'lib/board'
require_relative 'lib/player'
require_relative 'lib/player_input'
require_relative 'lib/constants'

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

 

def run_game(players)

    turn = 0

    coordinates = {

        "1" => [0,0],

        "2" => [0,1],

        "3" => [0,2],

        "4" => [1,0],

        "5" => [1,1],

        "6" => [1,2],

        "7" => [2,0],

        "8" => [2,1],

        "9" => [2,2]

    }

 

    board = Board.new

 

    while !game_over?(board, players[0].marker, players[1].marker) do

        player = players[turn%2]

        puts "IT'S #{player.name} TURN!"

        board.print_board

        input = ' '

        play = nil

        while !input.match?(/^[1-9]$/) || play == nil do

            puts "CHOOSE A FREE SQUARE!"

            input = gets.chomp

            play = valid_coordinates?(board, coordinates[input]) ? coordinates[input] : nil

        end

        board.mark_square(play[0], play[1], player.marker)

        turn += 1

    end

 

    display_result(players, board)

    show_scores(players)

end

 

def launch_game

    puts TITLE

    want_to_play = true

    players = [get_player(1), get_player(2)]

    while want_to_play do

        run_game(players)

        prompt = "DO YOU WANT A REMATCH? Y/N"

        want_to_play = get_confirmation(prompt)

    end

    puts "BYE!\n\n\n"

end

=end
colors = Constants::COLORS.keys.shuffle[0...Constants::NOTCHES].map { |key| Constants::COLORS[key] }

board = Board.new(Constants::ROWS, Constants::NOTCHES, colors)
puts board.printable_board
until board.winner? || board.full?
  candidate = PlayerInput.input_colors(Constants::COLORS, Constants::COLOR_PROMPT, Constants::NOTCHES)
  board.mark_row(candidate)
  puts board.printable_board
end
puts board.printable_solution
