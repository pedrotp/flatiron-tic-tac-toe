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

def get_empty_spaces(board)
  board.keys.select { |key| board[key] == "_"}
end

def computer_turn(board,computer_sym,user_sym,winning_keys)
  empty_spaces = get_empty_spaces(board)
  turns_played = board.values.count(computer_sym)
  winning_values = winning_keys.collect { |ary| ary.collect { |item| board[item] } }
  if turns_played == 0
    if empty_spaces.include?(:a1)
      board[:a1] = computer_sym
    else
      board[:b2] = computer_sym
    end
  else
    if winning_values.any? { |ary| ary.count(computer_sym) == 2 && ary.include?("_") }
      winning_keys[ winning_values.index { |ary| ary.count(computer_sym) == 2 && ary.include?("_") } ].each do |key|
        if board[key] == "_"
          board[key] = computer_sym
        end
      end
    elsif winning_values.any? { |ary| ary.count(user_sym) == 2 && ary.include?("_") }
      winning_keys[ winning_values.index { |ary| ary.count(user_sym) == 2 && ary.include?("_") } ].each do |key|
        if board[key] == "_"
          board[key] = computer_sym
        end
      end
    elsif winning_values.any? { |ary| ary.count("_") == 2 && ary.include?(computer_sym) }
      board[winning_keys[ winning_values.index { |ary| ary.count("_") == 2 && ary.include?(computer_sym) } ].find { |key| board[key] == "_" } ] = computer_sym
    end
  end
end

def play_game(board, user_sym)
  winning_keys = [[:a1,:a2,:a3],[:b1,:b2,:b3],[:c1,:c2,:c3],[:a1,:b1,:c1],[:a2,:b2,:c2],[:a3,:b3,:c3],[:a1,:b2,:c3],[:c1,:b2,:a3]]
  computer_sym = choose_computer_symbol(user_sym)
  winning_values = winning_keys.collect { |ary| ary.collect { |item| board[item] } }
  until winning_values.any? { |array| array.all? { |item| item == user_sym } } || winning_values.any? { |array| array.all? { |item| item == computer_sym } } || winning_values.all? { |array| array.include?(user_sym) && array.include?(computer_sym) }
    puts "Here's what the board looks like:"
    show_board(board)
    puts "Where do you want to place a mark? (type 'h' for instructions)"
    input = get_user_input
    empty_spaces = get_empty_spaces(board)
    if input == "h"
      instructions
    elsif empty_spaces.include?(input.to_sym)
      board[input.to_sym] = user_sym
      computer_turn(board,computer_sym,user_sym,winning_keys)
    else 
      puts "invalid input, try again"
    end
    winning_values = winning_keys.collect { |ary| ary.collect { |item| board[item] } }
  end
  if winning_values.any? { |array| array.all? { |item| item == user_sym } }
    show_board(board)
    puts "YOU WON!!! ٩(^ᴗ^)۶"
  elsif winning_values.any? { |array| array.all? { |item| item == computer_sym } }
    show_board(board)
    puts "The computer wins! ¯\\_(ツ)_/¯"
  elsif winning_values.all? { |array| array.include?(user_sym) && array.include?(computer_sym) }
    show_board(board)
    puts "It's a draw! No more possible winning moves :("
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