$game_board = [nil,nil,nil,nil,nil,nil,nil,nil,nil]
$num_board = (0..8).to_a # Shows available spots to player
$player_symbol = "X"
$computer_symbol = "O"
$player_turn = true # true if player's turn

############### Player functions

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

def game_draw()
  if $game_board.index(nil) == nil
    return true
  end
  return false
end

#################### Game functions

def reset()
  #Resets variables and switches player/computer symbols
  $game_board = [nil,nil,nil,nil,nil,nil,nil,nil,nil]
  $num_board = (0..8).to_a
  $player_symbol, $computer_symbol = $computer_symbol, $player_symbol
end

def get(b, i)
  # Safely grabs information from a board for print_boards()
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

##################### AI functions

def ai_check_rows(p)
  # Checks for two pieces & empy space (any order) with a player
  # Returns array of empty spaces
  rows = []
  3.times do |x|
    rows << (x-1)*3+2 if $game_board[(x-1)*3] == $game_board[(x-1)*3+1] && !$game_board[(x-1)*3+2] && $game_board[(x-1)*3] == p      
    rows << (x-1)*3 if $game_board[(x-1)*3 +1] == $game_board[(x-1)*3+2] && !$game_board[(x-1)*3] && $game_board[(x-1)*3 +1] == p
    rows << (x-1)*3+1 if $game_board[(x-1)*3] == $game_board[(x-1)*3+2] && !$game_board[(x-1)*3+1] && $game_board[(x-1)*3] == p
  end
  rows
end

def ai_check_columns(p)
  # Checks for two pieces & empy space (any order) with a player
  # Returns array of empty spaces
  columns = []
  3.times do |x|
    columns << x+5 if $game_board[x-1] == $game_board[x+2] && !$game_board[x+5] && $game_board[x-1] == p
    columns << x-1 if $game_board[x+2] == $game_board[x+5] && !$game_board[x-1] && $game_board[x+2] == p
    columns << x+2 if $game_board[x-1] == $game_board[x+5] && !$game_board[x+2] && $game_board[x-1] == p
  end
  columns
end

def ai_check_diagonals(p)
  # Checks for two pieces & empy space (any order) with a player
  # Returns array of empty spaces
  diagonals = []
  diagonals << 8 if $game_board[0] == $game_board[4] && !$game_board[8] && $game_board[0] == p
  diagonals << 0 if $game_board[4] == $game_board[8] && !$game_board[0] && $game_board[4] == p
  diagonals << 4 if $game_board[0] == $game_board[8] && !$game_board[4] && $game_board[0] == p
  diagonals << 6 if $game_board[2] == $game_board[4] && !$game_board[6] && $game_board[2] == p
  diagonals << 2 if $game_board[4] == $game_board[6] && !$game_board[2] && $game_board[4] == p
  diagonals << 4 if $game_board[2] == $game_board[6] && !$game_board[4] && $game_board[2] == p
  diagonals
end

def attempt_win()
  # Win if two of three spaces are already computer
  if ai_check_rows($computer_symbol).count() > 0
    $game_board[ai_check_rows($computer_symbol)[0].to_i] = $computer_symbol
    return true
  elsif ai_check_columns($computer_symbol).count() > 0
    $game_board[ai_check_columns($computer_symbol)[0].to_i] = $computer_symbol
    return true
  elsif ai_check_diagonals($computer_symbol).count() > 0
    $game_board[ai_check_diagonals($computer_symbol)[0].to_i] = $computer_symbol
    return true
  end
  false
end

def attempt_block()
  # If two of three spaces are player, play third space
  if ai_check_rows($player_symbol).count() > 0
    $num_board[ai_check_rows($player_symbol)[0].to_i] = " "
    $game_board[ai_check_rows($player_symbol)[0].to_i] = $computer_symbol
    return true
  elsif ai_check_columns($player_symbol).count() > 0
    $num_board[ai_check_columns($player_symbol)[0].to_i] = " "
    $game_board[ai_check_columns($player_symbol)[0].to_i] = $computer_symbol
    return true
  elsif ai_check_diagonals($player_symbol).count() > 0
    $num_board[ai_check_diagonals($player_symbol)[0].to_i] = " "
    $game_board[ai_check_diagonals($player_symbol)[0].to_i] = $computer_symbol
    return true
  end
  false
end

def attempt_fork()
  # Check corners/center and place piece if fork can be made
  power_spots = []
  [0, 2, 4, 6, 8].each do |x|
    power_spots << x if $game_board[x] == nil
  end
  if power_spots.count() > 1
    power_spots.each do |x|
      $game_board[x] = $computer_symbol
      if ai_check_rows($computer_symbol).count() + ai_check_columns($computer_symbol).count() + ai_check_diagonals($computer_symbol).count() == 2
        return true
      else
        $game_board[x] = nil
      end
    end
  end
  false
end

def block_fork()
  # Checks for forks by placing player in empty corners or center
  # If two forks, place piece on side (forces player to block next turn)
  # If one fork, place piece on fork
  power_spots = []
  forks = []
  [0, 2, 4, 6, 8].each do |x|
    power_spots << x if $game_board[x] == nil
  end
  if power_spots.count() > 1
    power_spots.each do |x|
      $game_board[x] = $player_symbol
      if ai_check_rows($player_symbol).count() + ai_check_columns($player_symbol).count() + ai_check_diagonals($player_symbol).count() == 2
        forks << x
      end
      $game_board[x] = nil
    end
    if forks.count() == 2
      $game_board.each_index do |x|
        if !forks.index(x) && $num_board.index(x)
          $game_board[x] = $computer_symbol
          $num_board[x] = " "
          return true
        end
      end
    elsif forks.count() == 1
      $game_board[forks[0]] = $computer_symbol
      $num_board[forks[0]] = " "
      return true
    end
  end
  false
end

def opposite_corner(c)
  return 8 if c == 0
  return 6 if c == 2
  return 2 if c == 6
  return 0 if c == 8
end

def play_opening()
  # 1 Play center
  # 2 Opposite corner if the opponent is in the corner
  # 3 Play empty corner
  # 4 Play empty side
  empty_corners = []
  if $num_board.index(4)
    $game_board[4] = $computer_symbol
    $num_board[4] = " "
    return 1
  end
  
  [0, 2, 6, 8].each do |x|
    if $game_board[x] == $player_symbol
      corner = opposite_corner(x)
      if $num_board.index(corner)
        $game_board[corner] = $computer_symbol
        $num_board[corner] = " "
        return 2
      end
    elsif $game_board[x] == nil
      empty_corners << x
    end
  end
  
  if empty_corners.count() > 0
    $game_board[empty_corners[0]] = $computer_symbol
    $num_board[empty_corners[0]] = " "
    return 3
  end
  
  $game_board.each_index do |x|
    if $game_board[x] == " "
      $game_board[x] = $computer_symbol
      $num_board[x] = " "
      return 4
    end
  end
end

####################### Program Logic

puts "Hello! Welcome to Tic Tac Toe! Anytime you'd like, you can type exit to quit the program."

loop do
  if $player_turn
    puts "Human, please type in the number of the spot that you would like to fill"
    print_boards()
    input = check_input(gets.chomp)
    $game_board[input] = $player_symbol
    $num_board[input] = " "
    $player_turn = !$player_turn
    
    if check_winner() # Should never be true
      puts "Congratuations Human! You Just Won!!!!"
      exit
    elsif game_draw()
      puts "The game is a draw!!!"
      reset()
      puts "Let's play again!"
    end
  end
  if !$player_turn
    if game_draw()
        puts "The game is a draw!!!"
        reset()
        puts "Let's play again!"
    elsif attempt_win()
      puts "Sorry Sir, but you've lost"
      print_boards()
      exit
     elsif attempt_block()
     elsif attempt_fork()
     elsif block_fork()
     else
       play_opening()
    end
    $player_turn = !$player_turn
  end
end