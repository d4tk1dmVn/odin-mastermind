require_relative 'constants'

module Outputable
  def self.colorize(color_key, text)
    escape_code = Constants::ANSI_ESCAPING[color_key]
    prefix = "\033[38;5;#{escape_code}m"
    suffix = "\033[0m"
    "#{prefix}#{text}#{suffix}"
  end

  def self.color_prompt
    color_keys = Constants::COLORS.keys
    prompt_text = ''
    color_keys.each do |color_key|
      color_name = Constants::COLORS[color_key]
      prompt_chunk = "(#{color_name[0]})#{color_name[1..]}"
      colorized_prompt_color = colorize(color_key, prompt_chunk)
      prompt_text += "#{colorized_prompt_color}\n"
    end
    prompt_text
  end
end
