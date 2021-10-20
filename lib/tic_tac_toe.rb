class TicTacToe

    attr_accessor :board

    @@all = []

    def self.all
        @@all
    end

    WIN_COMBINATIONS = [
        [0, 1, 2], # top row win
        [3, 4, 5], # middle row win
        [6, 7, 8], # bottom row win
        [0, 3, 6], # left vertical win
        [1, 4, 7], # middle vertical win
        [2, 5, 8], # right vertical win
        [6, 4, 2], # diagonal win 1
        [0, 4, 8] # diagonal win 2
        ]

    def play
        until self.over?
          self.turn
        end
      
        if self.won?
          puts "Congratulations #{self.winner}!"
        elsif self.draw?
          puts "Cat's Game!"
        end
    end

    def initialize
        self.board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
        self.class.all << self
    end

    def display_board
        puts " #{self.board[0]} | #{self.board[1]} | #{self.board[2]} "
        puts "-----------"
        puts " #{self.board[3]} | #{self.board[4]} | #{self.board[5]} "
        puts "-----------"
        puts " #{self.board[6]} | #{self.board[7]} | #{self.board[8]} "
    end

    def turn
        puts "Please enter 1-9:"
        input = gets.strip
        index = input_to_index(input)
        if valid_move?(index)
            move(index, self.current_player)
            self.display_board
        else
            self.turn
        end
    end

    def input_to_index(input)
        input.to_i - 1
    end

    def valid_move?(index)
        index.between?(0,8) && !position_taken?(index)
    end

    def position_taken?(index)
        (self.board[index] != " ") && (self.board[index] != "")
    end

    def turn_count
        occupied = 0
        self.board.each_with_index do |position, i|
            if self.position_taken?(i)
                occupied += 1
            end
        end
        occupied
    end
    
    def current_player
        (self.turn_count.even?) ? "X" : "O"
    end
    
    def move(index, current_player = "X")
        self.board[index] = current_player
    end

    def full?
        self.board.all? { |i| i == "X" || i == "O" }
    end

    def draw?
        (!self.won? && self.full?) ? true : false
    end

    def over?
        (self.draw? || self.won?) ? true : false
    end

    # return winning combination else false
    def won?
        WIN_COMBINATIONS.each do |combination|
            p1 = self.board[combination[0]]
            p2 = self.board[combination[1]]
            p3 = self.board[combination[2]]
        
            if self.position_taken?(combination[0]) && p1 == p2 && p2 == p3
                return combination
            end
        end
        false
    end
  
    # if won? return winning player's token else false
    # def winner(board)
    #     winning_combo = self.won?(board)
    #     if winning_combo then board[winning_combo[0]] end
    # end

    def winner
        winning_combo = self.won?
        if winning_combo
            return self.board[winning_combo[0]]
        else
            nil
        end
    end

end