require_relative 'messages.rb'
require_relative 'format.rb'
require 'json'
class UserIO
    include Messages
    
    def self.clear_screen
        puts `clear`
    end

    def self.main_menu
        puts INTRO
        puts OPTIONS

        input = gets.chomp
        return input if input.match('^[1-2]{1}$')

        puts INVALID_OPTION
        self.main_menu
    end

    def self.random_word
        words = File.readlines("words.txt")
        random_word = words[rand(0..words.length)].to_s.chomp.downcase
        return random_word
    end

    def self.display_game(turns_left, word, tried_letters)
        puts "Turns left: " + "#{turns_left}".green
        word.split("").each do |letter|
            if tried_letters.include?(letter)
                print " #{letter}".magenta
            else
                print " _".magenta
            end
        end

        puts "\n\nTried letters:" + " #{tried_letters}".cyan
    end

    def self.get_letter(tried_letters)
        puts GET_LETTER
        input = gets.chomp

        if tried_letters.include?(input)
            puts ALREADY_ATTEMPTED
            self.get_letter(tried_letters)
        end

        return input.downcase if input.match('^[a-zA-Z]{1}$') or input == "save"

        puts INVALID_OPTION
        self.get_letter(tried_letters)
    end

    def self.save_game(data)
        puts SAVE_NAME
        input = gets.chomp
        self.save_game unless input.match?('^[a-zA-Z1-9]')

        File.open("savegames/#{input}.json","w") { |f| f.write(data.to_json)}
    end

    def self.load_game()
        puts LOAD_GAME
        puts Dir["savegames/*.json"]
        input = gets.chomp
        self.load_game() unless input.match?('^[a-zA-Z1-9]')

        line = File.open("savegames/#{input}.json","r").read.chomp
        return JSON.parse(line)
    end
    
    def self.end_game(game_status, word)
        self.clear_screen

        puts LOSE if game_status == "lose"
        puts WIN if game_status == "win"
        puts "The word was " + "#{word}".green + "."
    end
end