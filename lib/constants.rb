module Constants
  SEPARATOR = '**********************************************'.freeze
  TITLE = "ODIN'S MACHIAVELLIAN MASTERMIND v1.0.0 - 2025".freeze
  NOTCHES = 4
  ROWS = 12
  # Colors Players choose from
  COLORS = {
    r: 'red',
    o: 'orange',
    y: 'yellow',
    g: 'green',
    b: 'blue',
    i: 'indigo',
    v: 'violet',
    n: 'none'
  }.freeze
  ANSI_ESCAPING = {
    r: '196',
    o: '208',
    y: '226',
    g: '46',
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
