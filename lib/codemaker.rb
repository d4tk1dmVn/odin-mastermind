require_relative 'computer'
# Computer class
class Codemaker < Computer
  # def initialize(notches, keys)
  #   super
  # end

  def generate_solution
    solution = []
    if [true, false].sample
      random_color_keys = keys.shuffle
      random_chunk = random_color_keys[0...notches]
      solution = random_chunk
    else
      solution = generate_hard_solution
    end
    solution
  end

  private

  def generate_hard_solution
    solution = []
    notches.times do
      solution << keys.sample
    end
    solution
  end
end
