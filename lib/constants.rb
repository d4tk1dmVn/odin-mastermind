module Constants
  SEPARATOR = '**********************************************'.freeze
  TITLE = "\nATHLON'S MACHIAVELLIAN MASTERMIND v1.0.0 - 2025\n".freeze
  NOTCHES = 4
  ROWS = 12
  COLORS = {
    r: "\033[31mRED\033[0m",                # Red text
    o: "\033[38;2;255;165;0mORANGE\033[0m", # Truecolor orange (RGB 255,165,0)
    y: "\033[33mYELLOW\033[0m",             # Yellow text (basic)
    g: "\033[32mGREEN\033[0m",              # Green text
    b: "\033[34mBLUE\033[0m",               # Blue text
    i: "\033[38;5;54mINDIGO\033[0m",        # Indigo with 256-color code (dark blue)
    v: "\033[35mVIOLET\033[0m",             # Magenta (violet)
    n: "\033[90;40mNONE\033[0m"             # White text on black background (space)
  }.freeze
  HINTS = {
    correct: "\033[32mCORRECT\033[0m",
    almost: "\033[33mALMOST\033[0m",
    incorrect: "\033[31mINCORRECT\033[0m"
  }.freeze
  COLOR_PROMPT = """
    \033[31m(r)ed\033[0m
    \033[38;2;255;165;0m(o)range\033[0m
    \033[33m(y)ellow\033[0m
    \033[32m(g)reen\033[0m
    \033[34m(b)lue\033[0m
    \033[38;5;54m(i)ndigo\033[0m
    \033[35m(v)iolet\033[0m
    \033[90;40m(n)one\033[0m """.freeze
end
