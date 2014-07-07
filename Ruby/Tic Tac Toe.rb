$game_board = [nil,nil,nil,nil,nil,nil,nil,nil,nil]
$num_board = (0..8).to_a

def check_rows()
  3.times do |x|
    if $game_board[(x-1)*3] == $game_board[(x-1)*3+1] && $game_board[(x-1)*3] == $game_board[(x-1)*3+2] && $game_board[(x-1)*3]
      return true
    end
  end
  return nil
end
    
def check_columns()
  3.times do |x|
    if $game_board[x-1] == $game_board[x+2] && $game_board[x+2] == $game_board[x+5] && $game_board[x-1]
      return true
    end
  end
  return nil  
end

def check_diagonals()
  if $game_board[0] == $game_board[4] && $game_board[4] == $game_board[8] && $game_board[0]
    return true
  elsif $game_board[2] == $game_board[4] && $game_board[4] == $game_board[6] && $game_board[2]
    return true
  end
  return nil
end

def check_winner()
  if check_rows()
    return check_rows()
  elsif check_columns()
    return check_columns()
  elsif check_diagonals()
    return check_diagonals()
  end
  return nil
end

def get(b, i)
  if b[i] == nil
    return " "
  else
    return b[i].to_s
  end
end

def print_board(b)
  puts get(b, 0) + "|" + get(b, 1) + "|" + get(b, 2)
  puts "-----"
  puts get(b, 3) + "|" + get(b, 4) + "|" + get(b, 5)
  puts "-----"
  puts get(b, 6) + "|" + get(b, 7) + "|" + get(b, 8)
end

def check_input(i)
  if i > 8 || i < 0 || $game_board[i] != nil
    puts "Sorry, that is an invalid input! Please try again"
    i = check_input(gets.chomp.to_i)
  end
  return i
end

def game_over()
  if $game_board.index(nil) == nil
    return true
  end
  return false
end

puts "Hello! Welcome to Tic Tac Toe!"
loop do
  puts "Player one, please type in the number of the spot that you would like to fill"
  print_board($num_board)
  input = check_input(gets.chomp.to_i)
  $game_board[input] = "X"
  $num_board[input] = " "
  puts "Here is the current game board"
  print_board($game_board)
  
  if check_winner()
    puts "Congratuations Player One! You Just Won!!!!"
    exit
  elsif game_over()
    puts "The game is a draw!!!"
    exit
  end
  
  puts "Player Two, please type in the number of the spot that you would like to fill"
  print_board($num_board)
  input = check_input(gets.chomp.to_i)
  $game_board[input] = "O"
  $num_board[input] = " "
  puts "Here is the current game board"
  print_board($game_board)
  
  if check_winner()
    puts "Congratuations Player Two! You Just Won!!!!"
    exit
  end
end