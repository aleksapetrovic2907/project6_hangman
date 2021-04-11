require_relative 'hangman.rb'
require_relative 'messages.rb'
require_relative 'user_io.rb'
class GameMenu
    include Messages

    def start
        UserIO.clear_screen()
        @option = UserIO.main_menu()
        play()
    end

    private
    def play
        start_new_game() if @option == '1'
        load_saved_game() if @option == '2'
    end

    def start_new_game
        game = Hangman.new(UserIO.random_word, 35, "")
        game.start
    end

    def load_saved_game
        data = UserIO.load_game
        game = Hangman.new(data["word"], data["turns_left"], data["tried_letters"])
        game.start
    end
end