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
    i: 'INDIGO',
    v: 'VIOLET',
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
    v: '200',
    i: '57',
    b: '21',
    n: '232'
  }.freeze
  HINTS = {
    correct: 'CORRECT',
    almost: 'ALMOST',
    incorrect: 'INCORRECT'
  }.freeze
  MAX_ROW_LENGTH = 80
end
