  require('pry')
  
  #  METHODS
  
  # Deal two cards to player and dealer
  def deal(player, dealer, decks)
    system 'clear'
    2.times do
      player.push(decks.delete(decks.sample))
      dealer.push(decks.delete(decks.sample))
    end
    display_cards(player)
  end
  
  # Show player cards and calculate current total
  def display_cards(hands)
    i = 0
    puts 'YOUR HAND:'
    hands.each do |card|
      puts " _____ "
      puts "|     |"
      puts "| #{hands[i]} |"
      puts "|     |"
      puts " ----- "
      i = i + 1
    end
  end
  
  # Show dealer's hand
  def dealer_shows(dealers_hand, players_hand, running_total1, running_total2)
    system 'clear'
    player_final_score(running_total1, running_total2)
    display_cards(players_hand)
    puts 
    puts
    puts "DEALER'S HAND:"
    i = 0
    dealers_hand.each do |card|
      puts " _____ "
      puts "|     |"
      puts "| #{dealers_hand[i]} |"
      puts "|     |"
      puts " ----- "
      i = i + 1
    end
  end
  
  def player_final_score(running_total1,running_total2)
    if running_total1 <= 21 && running_total2 <= 21 && running_total2 > running_total1
      return running_total2
    else
      return running_total1
    end
  end
  
  # Show game score
  def say_score(hands, person)
    total1 = calculate_total(hands)[:total1]
    total2 = calculate_total(hands)[:total2]
    if total1 == 21 || total2 == 21
      puts 
    elsif total1 == total2 
      puts "#{person} has #{total1}"  
    elsif total1 <= 21 && total2 <= 21
      puts "#{person} has #{total1} or #{total2}"
    elsif total2 > 21
      puts "#{person} has #{total1}"
    end
  end
  
  # calculate totals
 def calculate_total(array)
   running_totals = {:total1 => 0, :total2 => 0}
   ace_in_pack = false
   array.each do |card|
     if card.slice(0) == 'A'
       if ace_in_pack == true
         running_totals[:total1] = running_totals[:total1] + 1
         running_totals[:total2] = running_totals[:total2] + 1        
       elsif ace_in_pack == false
         running_totals[:total1] = running_totals[:total1] + 1
         running_totals[:total2] = running_totals[:total2] + 11  
         ace_in_pack = true      
       end    
     elsif card.slice(0) == 'J' || card.slice(0) == 'Q' || card.slice(0) == 'K' || card.slice(0..1) == '10'
       running_totals[:total1] = running_totals[:total1] + 10
       running_totals[:total2] = running_totals[:total2] + 10
     else 
       running_totals[:total1] = running_totals[:total1] + card.slice(0).to_i      
       running_totals[:total2] = running_totals[:total2] + card.slice(0).to_i      
     end
 
   end
   running_totals
 end
 
 # player hit or stay
 def player_hit_or_stay(running_total1, running_total2, decks, player, dealer)
   say_score(player, "Player")
   if running_total1 > 21 && running_total2 > 21 
     puts ">__< You Busted! >__<"
     sleep 1
     puts "Dealer wins."
     sleep 1.5
     puts "Better luck next time!"
   elsif running_total1 == 21 || running_total2 == 21 
     puts "That's Blackjack!"
     running_total1 = calculate_total(player)[:total1]
     running_total2 = calculate_total(player)[:total2]
     player_score = player_final_score(running_total1, running_total2)    
     running_total1 = calculate_total(dealer)[:total1]
     running_total2 = calculate_total(dealer)[:total2]
     dealer_score = player_final_score(running_total1, running_total2)
     puts say_score(dealer, "Dealer")
     sleep 1
     result(player_score, dealer_score)
   elsif running_total1 <= 20 || running_total2 <= 20
     puts 'Would you like to (h)it or (s)tay?'
     answer = gets.chomp.downcase
     while answer != 'h' && answer != 's'
       puts 'Press "h" to hit or press "s" to stay'
       answer = gets.chomp.downcase
     end
     if answer == 'h'
       sleep 1
       hit(decks, player)
       system 'clear'
       display_cards(player)
       running_total1 = calculate_total(player)[:total1]
       running_total2 = calculate_total(player)[:total2]
       player_hit_or_stay(running_total1, running_total2, decks, player, dealer)
     elsif answer == 's'
       dealer_shows(dealer, player, running_total1, running_total2)
       puts "You stayed on #{player_final_score(running_total1, running_total2)}"
       player_score = player_final_score(running_total1, running_total2)
       sleep 1
       running_total1 = calculate_total(dealer)[:total1]
       running_total2 = calculate_total(dealer)[:total2]
       puts say_score(dealer, "Dealer")
       sleep 1
       dealer_hit_or_stay(decks,running_total1,running_total2, player, dealer, player_score)
     end
   end
 end
 
 # dealer hit or stay
 def dealer_hit_or_stay(decks, running_total1,running_total2, player, dealer, player_score)
   if running_total1 > 21 && running_total2 > 21 
     puts "The dealer's busted! You win!"
     sleep 1
     puts "♣ ♥ ♠ ♦ Thank you for playing! ♣ ♥ ♠ ♦"
   elsif running_total1 == 21 || running_total2 == 21
     puts 'The dealer hit Blackjack!'
     running_total1 = calculate_total(dealer)[:total1]
     running_total2 = calculate_total(dealer)[:total2] 
     dealer_score = player_final_score(running_total1, running_total2)
     result(player_score, dealer_score)
   elsif running_total1 < 17 && running_total2 < 17
     puts 'Dealer Hits'
     hit(decks, dealer)
     sleep 2
     dealer_shows(dealer, player, running_total1, running_total2)
     puts "You stayed on #{player_score}"
     say_score(dealer, "Dealer")
     running_total1 = calculate_total(dealer)[:total1]
     running_total2 = calculate_total(dealer)[:total2] 
     dealer_hit_or_stay(decks, running_total1,running_total2, player, dealer, player_score)
   elsif running_total1 >= 17 && running_total1 <= 18
     gamble = ['yes', 'no']
     if gamble.sample == 'yes'
       puts 'Dealer hits...'
       hit(decks, dealer)
       sleep 2
       dealer_shows(dealer, player, running_total1, running_total2)
       running_total1 = calculate_total(dealer)[:total1]
       running_total2 = calculate_total(dealer)[:total2] 
       dealer_hit_or_stay(decks, running_total1,running_total2, player, dealer, player_score)
     elsif gamble.sample == 'no'
       puts 'Dealer stays!'
       sleep 2
       running_total1 = calculate_total(dealer)[:total1]
       running_total2 = calculate_total(dealer)[:total2] 
       dealer_score = player_final_score(running_total1, running_total2)
       result(player_score, dealer_score)
     end
     # if s result(player_score, dealer_score)
   elsif running_total1 >= 19 && running_total1 <= 20 || running_total2 >= 19 && running_total2 <= 20
     puts 'Dealer Stays!'
     running_total1 = calculate_total(dealer)[:total1]
     running_total2 = calculate_total(dealer)[:total2] 
     dealer_score = player_final_score(running_total1, running_total2)
     result(player_score, dealer_score)
   end
 end
 
 # deal new card
 def hit(deck, hand)
   hand.push(deck.delete(deck.sample))
   calculate_total(hand)
 end
 
 # result calc
 def result(player_score, dealer_score)
   if player_score == dealer_score
     puts "Both players scored #{player_score}"
     sleep 1
     puts "IT'S A DRAW!"
   elsif player_score > dealer_score
     puts "#{player_score} beats #{dealer_score}"    
     puts "♣ ♥ ♠ ♦ You Win! ♣ ♥ ♠ ♦"
   elsif dealer_score > player_score
     puts "#{dealer_score} beats #{player_score}"
     puts ">_< Dealer wins. >_<"
     sleep 1
     puts " Better luck next time!"
   end
 end
 
 
 #  GAME LOGIC
 
 # Game repeat and scoreboard 
 play_again = 'y'
 game_streak = 0
 results = { :wins => 0, :losses => 0, :draws => 0 } # store history
 
 
 while play_again == 'y'

   # initialize decks
   decks = ['Ah ', '2h ', '3h ', '4h ', '5h ', '6h ', '7h ', '8h ', '9h ', '10h', 'Jh ', 'Qh ', 'Kh ','Ad ', '2d ', '3d ', '4d ', '5d ', '6d ', '7d ', '8d ', '9d ', '10d', 'Jd ', 'Qd ', 'Kd ', 'As ', '2s ', '3s ', '4s ', '5s ', '6s ', '7s ', '8s ', '9s ', '10s', 'Js ', 'Qs ', 'Ks ', 'Ac ', '2c ', '3c ', '4c ', '5c ', '6c ', '7c ', '8c ', '9c ', '10c', 'Jc ', 'Qc ', 'Kc ', 'Ah ', '2h ', '3h ', '4h ', '5h ', '6h ', '7h ', '8h ', '9h ', '10h', 'Jh ', 'Qh ', 'Kh ','Ad ', '2d ', '3d ', '4d ', '5d ', '6d ', '7d ', '8d ', '9d ', '10d', 'Jd ', 'Qd ', 'Kd ', 'As ', '2s ', '3s ', '4s ', '5s ', '6s ', '7s ', '8s ', '9s ', '10s', 'Js ', 'Qs ', 'Ks ', 'Ac ', '2c ', '3c ', '4c ', '5c ', '6c ', '7c ', '8c ', '9c ', '10c', 'Jc ', 'Qc ', 'Kc ']
   
   # empty arrays to hold all players cards
   player = []
   dealer = []   
 
   # Deal two card to each player
   deal(player, dealer, decks)
 
   # player takes turn
   total1 = calculate_total(player)[:total1] 
   total2 = calculate_total(player)[:total2] 
   player_hit_or_stay(total1,total2, decks, player, dealer)
   total1 = calculate_total(player)[:total1] 
   total2 = calculate_total(player)[:total2] 
   p = player_final_score(total1, total2)
   total1 = calculate_total(dealer)[:total1] 
   total2 = calculate_total(dealer)[:total2] 
   d = player_final_score(total1, total2)
 
 
   sleep 0.5
  
   if d > 21
     results[:wins] = results[:wins] + 1
   elsif p <= 21 && p > d
     results[:wins] = results[:wins] + 1
   elsif p == d
     results[:draws] = results[:draws] + 1
   elsif d <= 21 && d > p
     results[:losses] = results[:losses] + 1
   elsif p > 21
     results[:losses] = results[:losses] + 1
   end
     
   game_streak = game_streak + 1
   per_wins = (results[:wins].to_f / game_streak.to_f * 100).round(2)
   puts "♣ ♥ ♠ ♦ ♣ ♥ ♠ ♦ ♣ ♥ ♠ ♦ ♣ ♥ ♠ ♦ ♣ ♥ ♠ ♦"
   puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
   puts "Current game streak is #{game_streak}"
   puts "You've won #{results[:wins]}, lost #{results[:losses]}, and drawn #{results[:draws]} games"
   puts "You've won #{per_wins}% of your total games played"
   puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
   puts "♣ ♥ ♠ ♦ ♣ ♥ ♠ ♦ ♣ ♥ ♠ ♦ ♣ ♥ ♠ ♦ ♣ ♥ ♠ ♦"
 
   # play again?
   puts "Play again? (y/n)"
   play_again = gets.chomp
 
 end