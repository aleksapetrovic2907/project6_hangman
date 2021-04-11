require_relative 'format.rb'

module Messages
    # other text
    INTRO = "Welcome to Hangman!".blue
    OPTIONS = " 1 ".green + "- Start a new game\n" + " 2 ".green + "- Load a saved game"
    INVALID_OPTION = "This is an invalid option.".red

    # game text
    GET_LETTER = "Write a letter to try out."
    ALREADY_ATTEMPTED = "You already tried this letter!".red
    WIN = "Congratulations!".blue + " You have guessed the word!"
    LOSE = "Welp. Better luck next time.".brown
    
    # save/load
    SAVE_NAME = "Please choose a save name for your file: ".green
    LOAD_GAME = "Please choose the proper load game: ".green
end