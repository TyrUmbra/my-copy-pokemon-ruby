#require neccesary files
require_relative "player"
# require_relative "battle"
 include GetInput
 include MethodsGame
class Game
  attr_accessor :name, :pokemon_name, :pokemon, :playyer1
  
  def initialize
    @name = ""
    @pokemon = ""
    @pokemon_name = ""
    @playyer1 = ""
  end

  def start
    #Create a welcome method(s) to get the name, pokemon and pokemon_name from the user
    puts welcome
    name = get_input("First, what is your name?")
    puts welcome_with_data(name)
    # puts "1. Charmander        2. Bulbasaur      3. Squirtle"
    starters = Pokedex::POKEMONS.select { |_name, data| data[:starter] == true }
    valid_starter = starters.keys

    pokemon = get_with_options2("Choose a starting pokemon",valid_starter)
    pokemon_name = get_pokemon_name(name,pokemon)
    # create_player
    playyer1 = Player.new(name,pokemon,pokemon_name)
    game_flow(playyer1,pokemon_name)
  end

  def train(playyer1,bot)
    # Complete this
    battle_bot = Battle.new(playyer1, bot )
    battle_bot.start
  end

  def challenge_leader(playyer1,leader)
    # Complete this
    battle_leader = Battle.new(playyer1, leader )
    battle_leader.start
  end

  def game_flow(playyer1,pokemon_name)
    options = [["fight", "leave"],["Train", "Leader", "Stats","Exit"]]
    action = ""
    until action == "Exit"
      action = print_menu
      case action
      when "Train"
        bot = Bot.new
        valor = desicion(options[0], playyer1, bot)
        train(playyer1,bot) if valor.downcase == "fight"
      when "Leader"
        leader = Leader.new
        valor1 = desicion(options[0],playyer1,leader,"fight!")
        challenge_leader(playyer1,leader) if valor1.downcase == "fight"
      when "Stats"
        show_stats(playyer1,pokemon_name)
      when "Exit"
        puts goodbye
      end
      puts "Invalid Option" unless options[1].include?(action)
    end
  end
end

game = Game.new
game.start