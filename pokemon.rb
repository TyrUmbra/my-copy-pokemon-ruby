# require neccesary files
require_relative "pokedex/pokemons"
require_relative "pokedex/moves"
# require_relative "battle"
# require_relative "game"

class Pokemon
  attr_reader :char_pokemon , :indivudal_stats, :species, :type, :moves, :name, :effort_points, :experience_got
  attr_accessor :current_move, :current_hp, :current_speed, :base_exp, :level, :effort_values, :stat
  # include neccesary modules

  # (complete parameters)
  def initialize(specie, name, level)
    @char_pokemon = Pokedex::POKEMONS[specie.capitalize]
    # Retrieve pokemon info from Pokedex and set instance variables
    @name = name || specie
    @species = specie.capitalize
    @level = level || 1
    @type = @char_pokemon[:type]
    @base_exp = @char_pokemon[:base_exp]
    @effort_points = @char_pokemon[:effort_points]
    @growth_rate = @char_pokemon[:growth_rate]
    @base_stats = @char_pokemon[:base_stats]
    @moves = @char_pokemon[:moves]
    @max_hp = @base_stats[:hp]
    # Calculate Individual Values and store them in instance variable
    @indivudal_stats = { hp: rand(0..31), attack: rand(0..31), defense: rand(0..31), special_attack: rand(0..31), special_defense: rand(0..31), speed: rand(0..31) }
    # Create instance variable with effort values. All set to 0
    @effort_values = { hp: 0, attack: 0, defense: 0, special_attack: 0, special_defense: 0, speed: 0 }
    @current_exp = 0
    @experience_got = 0
    @exp_tolevelup = 0
    @current_hp = 0
    @current_attack = 0
    @current_defense = 0
    @current_special_attack = 0
    @current_special_defense = 0
    @current_speed = 0
    @current_move = nil
    # Store the level in instance variable
    # If level is 1, set experience points to 0 in instance variable.
   
    # If level is not 1, calculate the minimum experience point for that level and store it in instance variable.
    # Calculate pokemon stats and store them in instance variable
    @stat = {
      hp: (((2 * @base_stats[:hp]+ @indivudal_stats[:hp] + (@effort_values[:hp]/4.0).floor) * @level / 100 + level + 10).floor),
      attack: ((((2 * @base_stats[:attack] + @indivudal_stats[:attack] + (@effort_values[:attack]/4.0).floor) * level / 100) + 5).floor),
      defense:  (((2 * @base_stats[:defense] + @indivudal_stats[:defense] + (@effort_values[:defense]/4.0).floor) * level / 100 + 5).floor),
      special_attack:  (((2 * @base_stats[:special_attack] + @indivudal_stats[:special_attack] + (@effort_values[:special_attack]/4.0).floor) * level / 100 + 5).floor),
      special_defense:  (((2 * @base_stats[:special_defense] + @indivudal_stats[:special_defense] + (@effort_values[:special_defense]/4.0).floor) * level / 100 + 5).floor),
      speed:  (((2 * @base_stats[:speed] + @indivudal_stats[:speed] + (@effort_values[:speed]/4.0).floor) * level / 100 + 5).floor),
    }
    
  
  end

  def prepare_for_battle
    # Complete this
    @current_hp = @stat[:hp]
    @current_attack = @stat[:attack]
    @current_defense = @stat[:defense]
    @current_special_attack = @stat[:special_attack]
    @current_special_defense = @stat[:special_defense]
    @current_speed = @stat[:speed]
  end

  def receive_damage
    # Complete this
  end

  def fainted?
    # Complete this
   if  @current_hp <= 0  
    true
   else
     false
   end
  end

  def attack(target)
    # Print attack message 'Tortuguita used MOVE!'
    puts "#{self.name} used #{self.current_move[:name]}!"
    # Accuracy check
    hits = @current_move[:accuracy] >= rand(1..100)
    # If the movement is not missed
    # -- Calculate base damage
    
    # -- Mutltiply damage by effectiveness multiplier and round down. Print message If neccesary
    # ---- "It's not very effective..." when effectivenes is less than or equal to 0.5
    # ---- "It's super effective!" when effectivenes is greater than or equal to 1.5
    # ---- "It doesn't affect [target name]!" when effectivenes is 0
    # -- Inflict damage to target and print message "And it hit [target name] with [damage] damage""
    if hits
      base_damage =(((2 * self.level / 5.0 + 2).floor * offensive_stat(self.current_move[:type], target.type) * @current_move[:power] / target_defensive_stat(self.current_move[:type],target)).floor / 50.0).floor + 2
      # -- Critical Hit check
      critical_hit = 16 == rand(1..16)
      # -- If critical, multiply base damage and print message 'It was CRITICAL hit!'
      if critical_hit
         current_damage = base_damage * 1.5
        puts "It was CRITICAL hit"
      else
        current_damage = base_damage
      end
      multi = offensive_stat(self.current_move[:type], target.type)
      # -- Effectiveness check
      if multi == 0.5
        current_damage *= 0.5
        puts "It's not very effective..."
      elsif multi == 2
        current_damage *= 2
        puts "It's super effective!"
      elsif multi == 0
        current_damage *= 0
        puts "It doesn't affect #{target.name}!"
      else
        current_damage *= 1
      end
      target.current_hp = target.current_hp - current_damage
      puts "And it hit #{target.name} with #{current_damage} damage"
    else
      puts "But it MISSED!"
    end
    # Else, print "But it MISSED!"
  end
  
  def increase_stats(target)
    # Increase stats base on the defeated pokemon and print message "#[pokemon name] gained [amount] experience points"
    @exp_tolevelup = (6 / 5.0 * level**3 - 15 * level**2 + 100 * level - 140).floor
    # If the new experience point are enough to level up, do it and print
    @experience_got = (target.base_exp * level / 7.0).floor
    @current_exp += @experience_got
    # message "#[pokemon name] reached level [level]!" # -- Re-calculate the stat
      if @current_exp >= @exp_tolevelup
        @level += 1
        calculate_effortValues(target)
        @stat = {
          hp: (((2 * @base_stats[:hp]+ @indivudal_stats[:hp] + (@effort_values[:hp]/4.0).floor) * @level / 100 + level + 10).floor),
          attack: ((((2 * @base_stats[:attack] + @indivudal_stats[:attack] + (@effort_values[:attack]/4.0).floor) * level / 100) + 5).floor),
          defense:  (((2 * @base_stats[:defense] + @indivudal_stats[:defense] + (@effort_values[:defense]/4.0).floor) * level / 100 + 5).floor),
          special_attack:  (((2 * @base_stats[:special_attack] + @indivudal_stats[:special_attack] + (@effort_values[:special_attack]/4.0).floor) * level / 100 + 5).floor),
          special_defense:  (((2 * @base_stats[:special_defense] + @indivudal_stats[:special_defense] + (@effort_values[:special_defense]/4.0).floor) * level / 100 + 5).floor),
          speed:  (((2 * @base_stats[:speed] + @indivudal_stats[:speed] + (@effort_values[:speed]/4.0).floor) * level / 100 + 5).floor),
        }
      end
  end
  
  # private methods: vtarget_defensive_stat
  private
  # Create here auxiliary methods
  def offensive_stat(type_attack,enemy_type)
    types_multipler = Pokedex::TYPE_MULTIPLIER
    multiplier_damage = 1
    types_multipler.each do |moves| 
      if moves[:user] == type_attack &&  moves[:target] == enemy_type[0]
        multiplier_damage = moves[:multiplier]
      end
    end
   multiplier_damage #[0.5]
  end

  def target_defensive_stat(type_attack,enemy)
   if type_attack == :normal
      enemy.stat[:defense]
   else
    enemy.stat[:special_defense]
    end
end

def calculate_effortValues(enemy)
  effort_po = enemy.effort_points
  effort_va = self.effort_values

  effort_va.each do |key, value| 
    if key == effort_po[:type] 
       value += effort_po[:amount]
    end
  end
  self.effort_values = effort_va
end

end