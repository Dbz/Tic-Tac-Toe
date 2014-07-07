var game_board = ["","","","","","","","",""];
var num_board = [0,1,2,3,4,5,6,7,8];
var player = 1;
var symbol = "x";

function check_rows() {
	var x = 0;
	for(;x < 3; x++)
	    if(game_board[x] == game_board[x+1] && game_board[x] == game_board[x+2] && game_board[x])
    	  return true;
  	return false;
}
    
function check_columns() {
	var x = 0;
	for(;x < 3; x++)
	    if (game_board[x] == game_board[x+3] && game_board[x] == game_board[x+6] && game_board[x])
    	  return true;
	return false;
}

function check_diagonals() {
    if (game_board[0] == game_board[4] && game_board[0] == game_board[8] && game_board[0])
        return true;
    else if (game_board[2] == game_board[4] && game_board[2] == game_board[6] && game_board[2])
        return true;
  return false;
}

function check_winner() {
    if (check_rows())
        return true;
    else if (check_columns())
        return true;
    else if (check_diagonals())
        return true;
  return false;
}

function game_over() {
  if ($.inArray("", game_board) == -1)
    return true;
  return false;
}

function reset() {
    game_board = ["","","","","","","","",""];
    num_board = [0,1,2,3,4,5,6,7,8];
    player = 1;
    symbol = "x";
    $("caption").text("Player " + player);
    var x = 1;
    for(;x<10;x++)
        $("#" + x).text(" ");
}

$(".cell").click(function() {
    var cell = $(this);
    var i = cell.attr('id');
    if (cell.text() !== " ")
        return
    game_board[i-1] = symbol;
    num_board[i-1] = " ";
    cell.text(symbol);
    
    if(check_winner()) {
        alert("Congratuations Player " + player + "! You Just Won!!!!")
        reset();
        return;
    }
    if(game_over()) {
        alert("The game is a draw!!!");
        reset();
        return;
    }
    if (player == 1) {
        player = 2;
        symbol = "o";
    }
    else {
        player = 1;
        symbol = "x";
    }
    
    $("caption").text("Player " + player);
}
);