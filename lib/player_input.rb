# PlayerInput module
module PlayerInput
  def self.input_name
    loop do
      puts "GIVE ME THE PLAYER'S NAME"
      input = gets.chomp
      return input if input.match(/\A(?=.*[a-zA-Z])[a-zA-Z0-9]+\z/)
    end
  end

  def self.confirm(prompt)
    puts prompt
    loop do
      input = gets.chomp
      return true if %w[y Y].include?(input)
      return false if %w[n N].include?(input)
    end
  end

  def self.player_name
    loop do
      player_name = input_name
      done = confirm("PLAYER'S NAME IS #{player_name}. IS THIS CORRECT? Y/N")
      return player_name if done
    end
  end

  def self.valid_color_input(color_list, candidate, notches)
    return false if candidate.length != notches

    candidate.all? { |color| color_list.include?(color) }
  end

  def self.get_color_input(color_list, notches)
    loop do
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
    get_color_input(colors.keys, notches)
  end
end
