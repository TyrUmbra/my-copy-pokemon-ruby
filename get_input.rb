module GetInput
    def get_input(prompt)
      input = ""
      while input.empty?
        puts prompt
        print "> "
        input = gets.chomp
      end
  
      input
    end
  
    def get_with_options(prompt, options)
      input = ""
      until options.include?(input.downcase)
        puts prompt
        print_options(options)
        print "> "
        input = gets.chomp
      end
  
      input
    end
  
    def print_options(options)
      options.each.with_index do |option, index|
        puts "#{index + 1}. #{option.capitalize}"
      end

    end

    def desicion(options,player, bot, mensaje = nil)
      mensaje_got = mensaje || "training"
      puts "#{player.name} challenge #{bot.name} for #{mensaje_got}"
      puts "#{bot.name} has a #{bot.pokemon.name} level #{bot.pokemon.level}"
      puts "What do you want to do now?"
      input = ""
      until options.include?(input.downcase)
        print_options(options)
        print "> "
        input = gets.chomp
      end
      input
    end
  end

  module MethodsGame
    def welcome
      ["#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#",
       "#$#$#$#$#$#$#$                               $#$#$#$#$#$#$#",
       "#$##$##$##$ ---        Pokemon Ruby         --- #$##$##$#$#",
       "#$#$#$#$#$#$#$                               $#$#$#$#$#$#$#",
       "#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#",
       "Hello there! Welcome to the world of POKEMON! My name is OAK!",
       "People call me the POKEMON PROF!",
       "This world is inhabited by creatures called POKEMON! For some people",
       "POKEMON are pets. Others use them For fights. Myself...",
       "I study POKEMON as a profession."]
    end
   
    def welcome_with_data(name)
     ["Right! So your name is #{name}!",
       "Your very own POKEMON legend is about to unfold! A world of",
       "dreams and adventures with POKEMON awaits! Lets go!",
       "Here, #{name}! There are 3 POKEMON here! Haha!",
       "When I was young, I was a serious POKEMON trainer.",
       "In my old age, I have only 3 left, but you can have one! Choose!\n\n"
     ]
    end
   
    def get_with_options2(prompt, options)
     input = ""
     until options.include?(input)
       puts prompt
       print_options2(options)
       print "> "
       input = gets.chomp
       puts "Invalid option" unless options.include?(input)
     end
   
     input
    end
   
    def print_options2(options)
     options.each.with_index do |option, index|
       print "#{index + 1}. #{option.capitalize}   "
     end
     puts ""
    end

    def print_menu
    puts "\n" + "-" * 30 + "Menu" + "-" * 30
    puts "1. Stats           2. Train          3. Leader"+"          4. Exit"
    puts "\n"
  
    print "> "
    gets.chomp.strip.capitalize
    end

    def get_pokemon_name(name,pokemon)
    puts ["You selected #{pokemon} Great choice!",
      "Give your pokemon a name?"]
    print "> "
    pokemon_name = gets.chomp
    pokemon_name = pokemon if pokemon_name.empty?
    puts ["#{name}, raise your young #{pokemon_name} by making it fight!",
    "When you feel ready you can challenge BROCK, the PEWTER's GYM LEADER"]

    pokemon_name
    end

    def goodbye
      # Complete this
      ["Thanks for playing Pokemon Ruby",
      "This game was created with love by: Elias Mesones, Carlos Mendoza, Camilo Huanca, Jairo Pinedo"]
    end

    def show_stats(jugador,pokemon_name)
      # Complete this
     puts ["#{pokemon_name}:",
      "Kind: #{jugador.pokemon.species}",
      "Level: #{jugador.pokemon.level}",
      "Type: #{jugador.pokemon.type}",
      "Stats:"]
      jugador.pokemon.stat.each do |stat, value|
        puts "#{stat}: #{value}"
      end
    end
  end
  
  module MethodsBattle
    def print_winner(winner,losser,player_poke)
      puts ["#{winner.name} WINS!",
            "#{losser.name} FAINTED!"]
      separate_content
      if winner == player_poke
       winner.increase_stats(losser)
       puts "#{winner.name} gained #{winner.experience_got} experience points"
      end
      puts "-"*20+"Battle Ended!"+"-"*20
     
    end

    def separate_content
      puts "-" * 50
    end
  end