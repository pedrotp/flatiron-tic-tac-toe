require 'pry'

def setup_board
  a1, a2, a3, b1, b2, b3, c1, c2, c3 = Array.new(9){"_"}
  board = {a1: a1, a2: a2, a3: a3, b1: b1, b2: b2, b3: b3, c1: c1, c2: c2, c3: c3}
  board
end

def show_board(board)
  puts "   1 2 3"
  puts "a: " + board[:a1] + " " + board[:a2] + " " + board[:a3]
  puts "b: " + board[:b1] + " " + board[:b2] + " " + board[:b3]
  puts "c: " + board[:c1] + " " + board[:c2] + " " + board[:c3]
end

def instructions
  puts "How to Play:"
  puts "To place a mark on the board, type in the coordinates and press <enter>."
  puts "i.e. for the top left corner type 'a1', for the bottom right corner type 'c3'"
  puts "To win, get three marks in a row in any direction!"
  puts "** To display these instructions again type 'h' **"
  puts ""
end

def get_user_input
  gets.chomp.downcase.gsub(/\s/,"")
end

def choose_user_symbol
  puts "What symbol do you want to use? Please type 'x' or 'o'"
  user_symbol = get_user_input
  puts "Great! Let's get started"
  puts ""
  user_symbol
end

def choose_computer_symbol(user_symbol)
  if user_symbol == "o"
    computer_symbol = "x"
  else
    computer_symbol = "o"
  end
  computer_symbol
end

def play_game(board, user_sym)

  winning_cases = [[:a1,:a2,:a3],[:b1,:b2,:b3],[:c1,:c2,:c3],[:a1,:b1,:c1],[:a2,:b2,:c2],[:a3,:b3,:c3],[:a1,:b2,:c3],[:c1,:b2,:a3]]
  computer_sym = choose_computer_symbol(user_sym)
  empty_spaces = board.keys
  until winning_cases.any? { |array| array.all? { |item| board[item] == user_sym } } || winning_cases.any? { |array| array.all? { |item| board[item] == computer_sym } }
    puts "Here's what the board looks like:"
    show_board(board)
    puts "Where do you want to place a mark? (type 'h' for instructions)"
    input = get_user_input
    if input == "h"
      instructions
    elsif empty_spaces.include?(input.to_sym)
      board[input.to_sym] = user_sym
      empty_spaces.delete(input.to_sym)
      comp_position = rand(empty_spaces.length)
      board[empty_spaces[comp_position]] = computer_sym
      empty_spaces.delete_at(comp_position)
    else 
      puts "invalid input, try again"
    end
  end
  if winning_cases.any? { |array| array.all? { |item| board[item] == user_sym } }
    show_board(board)
    puts "YOU WON!!! ٩(^ᴗ^)۶"
  elsif winning_cases.any? { |array| array.all? { |item| board[item] == computer_sym } }
    show_board(board)
    puts "The computer wins! ¯\\_(ツ)_/¯"
  end
end

def run_game
  puts "Welcome to Tic Tac Toe, Yo!"
  puts ""
  board = setup_board
  instructions
  user_sym = choose_user_symbol
  play_game(board, user_sym)
end

run_game