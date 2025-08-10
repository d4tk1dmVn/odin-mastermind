module Constants
  SEPARATOR = '**********************************************'.freeze
  TITLE = "ODIN'S MACHIAVELLIAN MASTERMIND v1.0.0 - 2025".freeze
  NOTCHES = 4
  ROWS = 12
  # Colors Players choose from
  COLORS = {
    r: 'RED',
    o: 'ORANGE',
    y: 'YELLOW',
    g: 'GREEN',
    b: 'BLUE',
    n: 'NONE'
  }.freeze
  ANSI_ESCAPING = {
    r: '196',
    incorrect: '196',
    o: '208',
    almost: '208',
    y: '226',
    g: '46',
    correct: '46',
    b: '21',
    n: '232',
    player: '204'
  }.freeze
  HINTS = {
    correct: 'CORRECT',
    almost: 'ALMOST',
    incorrect: 'INCORRECT'
  }.freeze
  MAX_ROW_LENGTH = 80
  CODEMAKER_MESSAGE = "\n CODEMAKER MODE \n Create a code of #{NOTCHES} colors, make the Computer break the code!\n".freeze
  CODEBREAKER_MESSAGE = "\n CODEBREAKER MODE \n The Computer creates a code of #{NOTCHES} colors, you must break it!\n".freeze
end
