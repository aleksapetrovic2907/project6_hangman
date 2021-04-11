require_relative 'user_io.rb'
class Hangman

    def initialize(word, turns_left, tried_letters)
        @input = nil
        @game_status = "in-progress"
        @data = {
            :word => word,
            :turns_left => turns_left,
            :tried_letters => tried_letters
        }
    end

    def start
        while @game_status == "in-progress"
            play_round()
        end
        UserIO.end_game(@game_status, @data[:word])
        exit(0)
    end

    private
    def play_round
        display_game()
        get_input()
        check_game_status()
    end

    def display_game
        UserIO.clear_screen()
        UserIO.display_game(@data[:turns_left], @data[:word], @data[:tried_letters])
    end

    def get_input
        @input = UserIO.get_letter(@data[:tried_letters])
        if @input == "save"
            UserIO.save_game(@data)
            get_input
        end
        @data[:tried_letters] += "#{@input}"
    end

    def check_game_status
        @data[:turns_left] -= 1 unless @data[:word].include?(@input)

        @game_status = "lose" if @data[:turns_left] == 0
        @game_status = "win" if @data[:word].split("").all? { |letter| @data[:tried_letters].include?(letter) }
    end

   
end