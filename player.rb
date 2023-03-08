# require neccesary files
require_relative "battle"

class Player
  include GetInput
  attr_reader :pokemon , :name
  
  # (Complete parameters)

  def initialize(name, pokemon_species, name_pokemon, level_pokemon = nil)
    # Complete this
    @name = name
    @level_pokemon = level_pokemon || 1
    @pokemon = Pokemon.new(pokemon_species, name_pokemon, @level_pokemon)
  end

  def select_move
    # Complete this
    move = get_with_options("Select a move to attack: ", @pokemon.moves)
    @pokemon.current_move = Pokedex::MOVES[move.downcase]
  end
end

# Create a class Bot that inherits from Player and override the select_move method
class Bot < Player
  
  def initialize
    pokemon_options = Pokedex::POKEMONS.keys
    selected_pokemon = pokemon_options.sample # ["Bulbasaur", "Charmander", "Squirtle", "Ratata", "Spearow", "Pikachu", "Onix"]
    super("Random Person", selected_pokemon, selected_pokemon.capitalize, rand(1..5))
  end
  
  def select_move
    move = @pokemon.moves.sample
    @pokemon.current_move = Pokedex::MOVES[move]
  end

end

class Leader < Player

  def initialize
    super("Gym Leader Brock", "Onix", "Onix", 10)
  end

  def select_move
    move = @pokemon.moves.sample
    @pokemon.current_move = Pokedex::MOVES[move]
  end

end

# battle class