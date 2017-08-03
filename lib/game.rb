class Game

attr_accessor :board, :player_1, :player_2

  def initialize(player_1 = "X", player_2 = "O", board = Board.new)
    @player_1 = player_1
    @player_2 = player_2
    @board = board
  end

  WIN_COMBINATIONS = [
    [0,1,2], #top row
    [3,4,5],
    [6,7,8],
    [0,3,6], #first col
    [1,4,7],
    [2,5,8],
    [0,4,8], #diag
    [2,4,6]
  ]

  def current_player
    self.board.turn_count.even? ? player_1.token : player_2.token
  end

  def over?
    won? || draw? || board.full?
  end

  def won?
    WIN_COMBINATIONS.detect do |combo|
      combo.all? {|cell| board[cell] == "player_1.token"} || combo.all? {|cell| board[cell] == "player_2.token"}
    end
  end

  def draw?
    !won? && board.full?
  end

  def winner
    player_1.token == won?[0] ? player_1 : player_2 if won?
  end

  def turn
    puts "Please enter 1-9:"
    index = current_player.move
    if board.valid_move?(index)
      board.update(index, current_player)
      board.display
    else
      turn
    end
  end
end
