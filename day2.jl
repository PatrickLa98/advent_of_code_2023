## Day 2

## Read the input file
cd("/Users/patricklauer/Documents/GitHub/advent_of_code_2023/")
games = open("day2_input.txt") do file
    # Splitting the file
    [split(line, ':')[2] |> strip for line in eachline(file)]
end

## Part A

## Define the max possible numbers per color
possible = Dict("red" => 12,
                "green" => 13,
                "blue" => 14
  )

  ## split every game in smaller components and check if 
  ## the smallest component (1 color in 1 round of 1 game) matches the maximum obtainable outcome

  ## create a data frame to store all information
using DataFrames
df = DataFrame(game_ID = [], round = [], color = [], possible = [])

## loop through all components of the games and check for possible outcomes
for i in 1: length(games)

    game = games[i]
    rounds = split(game, ';')

  for j in 1:length(rounds)

    round = rounds[j]
    colors = split(round, ',')

    for k in 1:length(colors)

      color = colors[k]
      n, col = split(color)

      if possible[col] + 1 > parse(Int64, n)
        works = 1
      else 
        works = 0
       end

     temp = DataFrame(game_ID = i, round = j, color = k, possible = works)
     df = [df; temp]

    end
  end
end

## get possible games and sum up
grouped_df = groupby(df, :game_ID)
possible_games = []

for i in 1:length(grouped_df)

  if sum(grouped_df[i].possible) == nrow(grouped_df[i])

       push!(possible_games, i)
      
  end
end

possible_games

sum(possible_games)

## Part B

## using loop from Part A to create a data frame with 1 color *with information about n* per round per game as a row
df = DataFrame(game_ID = [], round = [], color = [], n = [])

for i in 1: length(games)

  game = games[i]
  rounds = split(game, ';')

  for j in 1:length(rounds)

    round = rounds[j]
    colors = split(round, ',')

    for k in 1:length(colors)

      color = colors[k]
      n, col = split(color)

      temp = DataFrame(game_ID = i, round = j, color = col, n = parse(Int64,n))
      df = [df; temp]
    end
  end
end

## trying out Chain and DataFrame package for data wrangling
## filtering for maximum draws per color per game
## multiply the max draws per color per game
## sum up products across games

using Chain
@chain df begin
  groupby([:game_ID, :color])
  combine(:n => maximum)
  groupby(:game_ID)
  combine(:n_maximum => prod)
 combine(:n_maximum_prod => sum)

end

