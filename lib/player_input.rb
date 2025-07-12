# PlayerInput module
module PlayerInput
  def input_name(player_number)
    loop do
      puts "GIVE ME PLAYER #{player_number}'S NAME"
      input = gets.chomp
      return input if input.match(/\A(?=.*[a-zA-Z])[a-zA-Z0-9]+\z/)
    end
  end

  def confirm(prompt)
    puts prompt
    loop do
      input = gets.chomp
      return true if ['y', 'Y'].include?(input)
      return false if ['n', 'N'].include?(input)
    end
  end

  def get_player_name(number)
    while
      player_name = input_name(number)
      done = confirm("PLAYER #{number}'S NAME IS #{player_name}. IS THIS CORRECT? Y/N")
      return player_name if done
    end
  end

  def self.valid_color_input(color_list, candidate, notches) 
    return false if candidate.length != notches

    candidate.all? { |color| color_list.include?(color) }
  end

  def self.get_color_input(color_list, notches)
    while
      input = gets.chomp.chars.map(&:to_sym)
      return input if valid_color_input(color_list, input, notches)

      puts 'WRONG INPUT'
    end
  end

  def self.input_colors(colors, colors_prompt, notches)
    puts 'THE VALID COLORS ARE'
    puts colors_prompt
    puts "YOU MAY CHOOSE #{notches} COLORS"
    puts "To choose a color type it's first letter"
    input_as_list = get_color_input(colors.keys, notches)
    input_as_list.map { |color_key| colors[color_key] }
  end
end
