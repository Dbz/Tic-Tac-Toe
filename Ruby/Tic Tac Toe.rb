$game_board = [nil,nil,nil,nil,nil,nil,nil,nil,nil]
$num_board = (0..8).to_a # Shows available spots to players

def check_rows()
  # Returns true if row is filled by player
  3.times do |x|
    if $game_board[(x-1)*3] == $game_board[(x-1)*3+1] && $game_board[(x-1)*3] == $game_board[(x-1)*3+2] && $game_board[(x-1)*3]
      return true
    end
  end
  return nil
end
    
def check_columns()
  # Returns true if column is filled by player
  3.times do |x|
    if $game_board[x-1] == $game_board[x+2] && $game_board[x+2] == $game_board[x+5] && $game_board[x-1]
      return true
    end
  end
  return nil  
end

def check_diagonals()
  # Returns true if diagonal is filled by player
  if $game_board[0] == $game_board[4] && $game_board[4] == $game_board[8] && $game_board[0]
    return true
  elsif $game_board[2] == $game_board[4] && $game_board[4] == $game_board[6] && $game_board[2]
    return true
  end
  return nil
end

def check_winner()
  if check_rows()
    return true
  elsif check_columns()
    return true
  elsif check_diagonals()
    return true
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

def print_boards()
  print get($num_board, 0) + "|" + get($num_board, 1) + "|" + get($num_board, 2)
  puts "     " + get($game_board, 0) + "|" + get($game_board, 1) + "|" + get($game_board, 2)
  puts "-----     -----"
  print get($num_board, 3) + "|" + get($num_board, 4) + "|" + get($num_board, 5)
  puts "     " + get($game_board, 3) + "|" + get($game_board, 4) + "|" + get($game_board, 5)
  puts "-----     -----"
  print get($num_board, 6) + "|" + get($num_board, 7) + "|" + get($num_board, 8)
  puts "     " + get($game_board, 6) + "|" + get($game_board, 7) + "|" + get($game_board, 8)
end

def check_input(i)
  #Checks input and exits program
  if (i.downcase() == "exit")
    exit
  elsif !(i =~ /^[012345678]{1}$/) || $game_board[i.to_i] != nil
    puts "Sorry, that is an invalid input! Please try again"
    i = check_input(gets.chomp)
  end
  return i.to_i
end

def game_draw()
  if $game_board.index(nil) == nil
    return true
  end
  return false
end

puts "Hello! Welcome to Tic Tac Toe!"
loop do
  puts "Player one, please type in the number of the spot that you would like to fill"
  print_boards()
  input = check_input(gets.chomp)
  $game_board[input] = "X"
  $num_board[input] = " "
  
  if check_winner()
    print_boards()
    puts "Congratuations Player One! You Just Won!!!!"
    exit
  elsif game_draw()
    puts "The game is a draw!!!"
    exit
  end
  
  puts "Player Two, please type in the number of the spot that you would like to fill"
  print_boards()
  
  input = check_input(gets.chomp)
  $game_board[input] = "O"
  $num_board[input] = " "
  
  if check_winner()
    print_boards()
    puts "Congratuations Player Two! You Just Won!!!!"
    exit
  end
end