

class WrongNumberOfPlayersError < StandardError ; end
class NoSuchStrategyError < StandardError ; end


def rps_game_winner(game)
  raise WrongNumberOfPlayersError unless game.length == 2
  
  first = game.first
  last = game.last
  
  if is_player_move? first then 
    return play(first, last)
  end
  
  play(
    rps_game_winner(first),
    rps_game_winner(last)
  )
  
end

def rps_tournament_winner(tournament)
  rps_game_winner tournament
end


# Helper methods
def is_player_move?(player)
  player.first.instance_of? String
end

def play(player1, player2)
  available_moves = /[RPS]/i
  
  strategy1 = player1.last
  raise NoSuchStrategyError unless strategy1 =~ available_moves
  
  strategy2 = player2.last
  raise NoSuchStrategyError unless strategy2 =~ available_moves
  
  first_player_won?(strategy1.upcase, strategy2.upcase) ? player1 : player2
end

def first_player_won?(strategy1, strategy2)
  not (
      (strategy1 == "P" and strategy2 == "S") or
      (strategy1 == "R" and strategy2 == "P") or
      (strategy1 == "S" and strategy2 == "R")
  )
end

# Tests

# # => returns the list ["Dave", "S"] wins since S>P
game = [ [ "Armando", "P" ], [ "Dave", "S" ] ]


# # => [“Richard”, “R”]
tournament = [
 [
   [ ["Armando", "P"], ["Dave", "S"] ],
   [ ["Richard", "R"],  ["Michael", "S"] ],
 ],
 [ 
   [ ["Allen", "S"], ["Omer", "P"] ],
   [ ["David E.", "R"], ["Richard X.", "P"] ]
 ]
]

puts rps_game_winner(game).to_s
puts rps_tournament_winner(tournament).to_s
