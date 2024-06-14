
using DataFrames

## Part A

# Read file
cd("/Users/patricklauer/Documents/GitHub/advent_of_code_2023/")
lines = readlines("day4_input.txt")

## create empty data frame 
cards = DataFrame(card = [], winning_numbers = [], your_numbers = [])

## store information in data frame
for i in 1:length(lines)
    card, numbers = split(lines[i], ":") #split cards and numbers
    winning_numbers, your_numbers = split(numbers, "|")  # split winning and your numbers
    ## remove whitespaces and transform to Integer values
    winning_numbers = split(winning_numbers, ' ')
    winning_numbers = parse.(Int64, filter(x -> x != "", winning_numbers))
    your_numbers = split(your_numbers, ' ')
    your_numbers = parse.(Int64, filter(x -> x != "", your_numbers))
   ## safe in data frame 
    temp = DataFrame(card = card, winning_numbers = [winning_numbers], your_numbers = [your_numbers])
    cards = [cards; temp]
end

## create new columns containing the number of wins and the respective points 
## use 0 as baseline value
cards.wins = zeros(Int64, length(cards.card))
cards.points = zeros(Int64, length(cards.card))
## loop through cards
for i in 1: length(cards.card)
    wins = 0  #reset wins after each card
    for j in 1: length(cards.winning_numbers[i])
        
        if cards.winning_numbers[i][j] in cards.your_numbers[i]

            wins = wins + 1 # if the winning number is in your numbers add a win
        end
    end

cards.wins[i] = wins
    if wins != 0
     cards.points[i] = 2^(wins - 1) ## safe points, since 1 win is one point and then doubles, it follows the exponential
    else
     cards.points[i] = 0
    end

end

println(sum(cards.points))


## Part B

### PRELIMINARY, DOES NOT WORK YET

##1. go through every card
## duplicate subsequent cards (n subsequent cards -> according to wins of focal)
## place the duplicated cards below the original of the respective value of subsequent cards


# recreate card column as integers to be able to perform + operations subsequently
cards.card = 1:length(cards.wins)

for i in 1: length(cards.card)
    for j in 0:cards[i, :].wins

        if j == 0 # dont duplicate any cards if no wins
         continue
         else
         ## i + j means the focal card + sequence of wins e.g. if focal card1 (i = 1) and second we are sequencing through the second win (j = 2), we duplicate card3
    
          temp =  cards[cards[i, :].card + j, :] # carts will shift once we insert copies. This specifies to create dublicate the value of the higher card (value) compared to our focal card i. Value of duplicate dependent on sequency of wins j

          position = (findfirst(row -> row.card == temp.card, eachrow(cards))) + 1 # insert new row after the first occurence of the respective card value
    
          insert!(cards, position, temp)
        end
    end
end

length(cards.card)

## seems to just copy card 2 many many times!!!11!