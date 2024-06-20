
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

# 1.
##create a dictionary containing card win information
wins = cards.wins
card = collect(1:nrow(cards))
card_win = Dict(card .=> wins)
## create a vector that counts the number of cards 
## initiated with 1 copy per card
n_cards = ones(Int, length(card))

## add copies to card 
for i in 1:(length(card)-1)
    n_win =  card_win[i]
    n_cards[i+1:i+n_win] .+= n_cards[i]
end

sum(n_cards)



## First version

## DOES NOT WORK: Just keeps on evaluating, worked on simplified example (probably to slow to iterate and fullcopy all the cards)
cardsB = [card wins]

## Initiate
i = 1
max_iteration = length(card)

while i <= max_iteration
    
        wins = cardsB[i, 2] ## the wins are stored at the 2nd index of the matrix

    for j in 0:wins

        if j == 0 # dont duplicate any cards if no wins
         continue
        end
        
        ## which card is copied (depends on the initial card i (stored in 1st index of matrix) and the iteration of j)
        copy_card = cardsB[i, 1] + j
            if copy_card >= maximum(card) + 1  ## stop the copying process at max copyable card (my input contains 197 cards)
              continue
            end 
           
           ## How many wins does the card to be copyed contain
           copy_wins = cardsB[copy_card,2]

        ## add copied card to matrix
            copy = [copy_card  copy_wins]
            cardsB = vcat(cardsB, copy)

    end
 i += 1
 max_iteration = length(cardsB[:,1])

end

length(cardsB[:,1])



