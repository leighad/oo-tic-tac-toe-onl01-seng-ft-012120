require 'pry'
class TicTacToe
    WIN_COMBINATIONS = [
        [0,1,2], [3,4,5], [6,7,8], [0,3,6], 
        [1,4,7], [2,5,8], [0,4,8], [6,4,2]
    ].freeze
# .freeze will make the constant variable immutable

    def initialize(board = nil)
        @board = board || Array.new(9, " ")
    end

    def display_board
        puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
        puts "-----------"
        puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
        puts "-----------"
        puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
        
    end

    def input_to_index(user_input)
        user_input_integer = user_input.to_i - 1
    end

    def move(index, player)
        @board[index] = player
    end

    def position_taken?(index)
        @board[index] == 'X' || @board[index] == 'O'
    end

    def valid_move?(index)
        index.between?(0, 8) && !position_taken?(index)
    end

    def turn_count
        @board.count {|position| position == 'X' || position == 'O'}
    end

    def current_player
        turn_count % 2 == 0 ? 'X' : 'O'
    end

    def turn
        puts 'Please enter 1-9:'
        user_input = gets.strip
        index = input_to_index(user_input)

        if valid_move?(index)
            move(index, current_player)
            display_board
        else
            turn
        end
    end

# this one was a bit of a challenge: 
# iterate over win_combos, using each combo determine
# if the input makes a match and return that combo
    def won?
        WIN_COMBINATIONS.detect do |combo|
          if position_taken?(combo[0]) && 
            @board[combo[0]] == @board[combo[1]] && 
            @board[combo[1]] == @board[combo[2]]
            combo
          end
        end
    end

    def full?
        @board.all? {|position| position != " "}
    end

    def draw?
        full? && !won?
    end

    def over?
        draw? || won?
    end

    # def winner
    #     if won?.include?('X')
    #         puts 'X'
    #     elsif won?.include?('O')
    #         puts 'O'
    #     else
    #         nil
    #     end
    # end

    def winner
        if combo = won? 
            @board[combo[0]] 
        end
    end

    def play 
        turn until over?
            puts winner ? "Congratulations #{winner}!" : "Cat's Game!"
        # end
    end

    # def play
    #     turn until over?
    #     if won?
    #       puts "Congratulations #{winner}!"
    #     elsif draw?
    #       puts "Cat's Game!"
    #     end
    # end
end