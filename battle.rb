require_relative "pokemon"
require_relative "get_input"
include MethodsBattle
class Battle
  # (complete parameters)
  attr_reader :name, :player_poke

  def initialize(player,bot)
    # Complete this
    @player = player
    @bot = bot
    @player_poke = @player.pokemon
    @bot_poke = @bot.pokemon
  end

  def start
    # Prepare the Battle (print messages and prepare pokemons)
    @player_poke.prepare_for_battle
    @bot_poke.prepare_for_battle
  
    battle_loop
    # --Calculate which go first and which second
    winner = @player_poke.fainted? ? @bot_poke : @player_poke
    losser = winner == @player_poke ? @bot_poke : @player_poke
    # Check which player won and print messages
    # If the winner is the Player increase pokemon stats
    print_winner(winner,losser,player_poke)
  end
   private

  def select_first(player_poke, bot_poke)
    player_move = @player_poke.current_move
    bot_move = @bot_poke.current_move

    if player_move[:priority] > bot_move[:priority]
      player_poke
    elsif player_move[:priority] < bot_move[:priority]
      bot_poke
    elsif player_poke.current_speed > bot_poke.current_speed
      player_poke
    elsif player_poke.current_speed < bot_poke.current_speed
      bot_poke
    else
      [player_poke, bot_poke].sample
    end
  end

  def battle_loop
    puts before_battle
    until @player_poke.fainted? ||  @bot_poke.fainted?
      puts show_contender
      @player.select_move
      @bot.select_move
  
      first = select_first(@player_poke, @bot_poke)
      second = first == @player_poke ? @bot_poke : @player_poke
  
      separate_content
      first.attack(second)
      second.attack(first) unless second.fainted?
      separate_content
    end
  end

  def before_battle
    ["#{@bot.name} sent out #{@bot_poke.name.upcase}!",
     "#{@player.name} sent out #{@player_poke.name.upcase}!",
     "-------------------Battle Start!-------------------"]
  end

  def show_contender
    ["#{@player.name}'s #{@player_poke.name.upcase} - Level #{@player_poke.level}","HP: #{@player_poke.current_hp}",
      "#{@bot.name}'s #{@bot_poke.name.upcase} - Level #{@bot_poke.level}","HP: #{@bot_poke.current_hp}\n\n"]  
  end
end