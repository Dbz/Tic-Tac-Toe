$game_board = [nil,nil,nil,nil,nil,nil,nil,nil,nil]
$num_board = (0..8).to_a

def check_rows(array)
  3.times do |x|
    if array[x-1] == array[x] && array[x] == array[x+1] && array[x]
      return array[x]
    end
  end
  return nil
end
    
def check_columns(array)
  3.times do |x|
    if array[x-1] == array[x+2] && array[x+2] == array[x+5] && array[x-1]
      return array[x-1]
    end
  end
  return nil  
end

def check_diagonals(array)
  if array[0] == array[4] && array[4] == array[8] && array[0]
    return array[0]
  elsif array[2] == array[4] && array[4] == array[6] && array[2]
    return array[2]
  end
  return nil
end

def check_winner(array)
  if check_rows(array)
    return check_rows(array)
  elsif check_columns(array)
    return check_columns(array)
  elsif check_diagonals(array)
    return check_diagonals(array)
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

def print_board(array)
  puts get(array, 0) + "|" + get(array, 1) + "|" + get(array, 2)
  puts "-----"
  puts get(array, 3) + "|" + get(array, 4) + "|" + get(array, 5)
  puts "-----"
  puts get(array, 6) + "|" + get(array, 7) + "|" + get(array, 8)
end

def is_available(i)
  if $game_board[i] != nil
    return false
  end
  return true
end

def check_input(input)
  if input > 8 || input < 0 || !is_available(input)
    puts "Sorry, that is an invalid input! Please try again"
    input = check_input(gets.chomp.to_i)
  end
  return input
end

puts "Hello! Welcome to Tic Tac Toe!"
loop do
  print "Player one, "
  puts "please type in the number of the spot that you would like to fill"
  print_board($num_board)
  input = check_input(gets.chomp.to_i)
  $game_board[input] = "X"
  $num_board[input] = " "
  puts "Here is the current game board"
  print_board($game_board)
  
  if check_winner($game_board)
    puts "Congratuations! You just won!!!!"
    break
  end
  
  print "Player two "
  puts "Please type in the number of the spot that you would like to fill"
  print_board($num_board)
  input = check_input(gets.chomp.to_i)
  $game_board[input] = "O"
  $num_board[input] = " "
  puts "Here is the current game board"
  print_board($game_board)
  
  if check_winner($game_board)
    puts "Congratuations! You just won!!!!"
    break
  end
end