using DataFrames

## Read input
cd("/Users/patricklauer/Documents/GitHub/advent_of_code_2023/")
input = readlines("day7_input.txt")

## split input in separte hand and bid vectors
hands = []
bids = Int[]
for line in input

    parts = split(line)
    push!(hands, parts[1])
    push!(bids, parse(Int64, parts[2]))
end

## 1. Count cards in hand
## 2. Define card strength values
## 3. Collect information in Data Frame
## 4. Determine rank of hand and multiply with bids


## 1. Count the cards 
function count_cards(hand) 
    hand = split(hand, "")

    card_count = Dict{String, Int}()

    for i in hand
        if haskey(card_count, i)
            card_count[i] += 1
        else
            card_count[i] = 1
        end
    end
   return card_count
end

## Part A

## 2. Define strength of each card
card_strength_rank = Dict{String, Int}()
different_cards = ["2", "3", "4", "5", "6", "7", "8","9","T","J","Q","K","A"]
for i in 1:13
    card_strength_rank[different_cards[i]] = i
end

## 3. Collect information in Data Frame

## create df with player, hand and bid information
## add empty columns to be filled in the following for:
##  different cardvalue rankings
## duplicate, triplicate, quadruplicate, fiveruplicate (dont know the correct term for that) and fullhouse information
df = DataFrame(
    player = collect(1:length(hands)),
    hand = hands,
    card1 = zeros(Int64, length(hands)),
    card2 = zeros(Int64, length(hands)),
    card3 = zeros(Int64, length(hands)),
    card4 = zeros(Int64, length(hands)),
    card5 = zeros(Int64, length(hands)),
    duplicate = zeros(Int64, length(hands)),
    triplicate = zeros(Int64, length(hands)),
    quadruplicate = zeros(Int64, length(hands)),
    fiveruplicate = zeros(Int64, length(hands)),
    fullhouse = zeros(Int64, length(hands)),
    bid = bids
    )

## fill different cards in hand with the card strength rankings defined in Dictionary card_strength_rank
for i in 1:length(hands) 

    hand = split(hands[i], "")

    df.card1[i] = card_strength_rank[string(hand[1])]
    df.card2[i] = card_strength_rank[string(hand[2])]
    df.card3[i] = card_strength_rank[string(hand[3])]
    df.card4[i] = card_strength_rank[string(hand[4])]
    df.card5[i] = card_strength_rank[string(hand[5])]

end

## collect information about duplicate/multiplicate cards and special case fullhouse


for i in 1:length(hands)

    counts = collect(values(count_cards(hands[i])))
    ## duplicates
    duplicates = sum([counts[j] == 2 for j in 1:length(counts)])
    df.duplicate[i] = duplicates
    ## triplicates
    triplicates = sum([counts[j] == 3 for j in 1:length(counts)])
    df.triplicate[i] = triplicates
    ## quadruplicate
    quadruplicate = sum([counts[j] == 4 for j in 1:length(counts)])
    df.quadruplicate[i] = quadruplicate
    ## fiveruplicate
    fiveruplicate = sum([counts[j] == 5 for j in 1:length(counts)])
    df.fiveruplicate[i] = fiveruplicate
    ## fullhouse
    fullhouse = 0
    if duplicates == 1 && triplicates == 1
        fullhouse = 1
    end
    df.fullhouse[i] = fullhouse
end

df
## 4. Determine rank of players based on multiplcate with 5>4>fullhouse>3>2>highcard (counting order from card1 to 5)
   
## create scores based on weighted conditions

df.score .= 0
for i in 1:nrow(df)

    if df[i,:].fiveruplicate == 1
        df[i,:].score += 7
     elseif df[i,:].quadruplicate == 1
        df[i,:].score += 6
     elseif df[i,:].fullhouse == 1
        df[i,:].score += 5
     elseif df[i,:].triplicate == 1
        df[i,:].score += 4
     elseif df[i,:].duplicate == 2
        df[i,:].score += 3
     elseif df[i,:].duplicate == 1
        df[i,:].score += 2
    end
end

## sort by conditions and use high cards to resolve equal scores
sort!(df, :score, rev = true)

## multiply scores by 100 so I can add the Integer values of card1 to tied scores without shifting total scores
df.score = df.score * 100
## add weights of heigh cards1 to scores
df.score = df.score + df.card1

## multiply scores by 100 again so if there are still any ties they can be resolved by adding the weights of cards2 but dont bias the scores of untied cards
df.score = df.score * 100
## add weights of heigh cards1 to scores
df.score = df.score + df.card2

## repeat the multiplying score adding steps till card 5 is reached to be safe

df.score = df.score * 100
df.score = df.score + df.card3

df.score = df.score * 100
df.score = df.score + df.card4

df.score = df.score * 100
df.score = df.score + df.card5

## sort cards again and rank them

sort!(df, :score)

df.rank = 1:nrow(df)

## get results 
df.winnings = df.rank .* df.bid

sum(df.winnings)


## PART B

## Copy the code for Part A and alterate conditions for J card

## 2. Define strength of each card
card_strength_rank = Dict{String, Int}()
different_cards = ["J", "2", "3", "4", "5", "6", "7", "8","9","T","Q","K","A"]
for i in 1:13
    card_strength_rank[different_cards[i]] = i
end

## 3. Collect information in Data Frame

## create df with player, hand and bid information
## add empty columns to be filled in the following for:
##  different cardvalue rankings
## duplicate, triplicate, quadruplicate, fiveruplicate (dont know the correct term for that) and fullhouse information
df = DataFrame(
    player = collect(1:length(hands)),
    hand = hands,
    card1 = zeros(Int64, length(hands)),
    card2 = zeros(Int64, length(hands)),
    card3 = zeros(Int64, length(hands)),
    card4 = zeros(Int64, length(hands)),
    card5 = zeros(Int64, length(hands)),
    duplicate = zeros(Int64, length(hands)),
    triplicate = zeros(Int64, length(hands)),
    quadruplicate = zeros(Int64, length(hands)),
    fiveruplicate = zeros(Int64, length(hands)),
    fullhouse = zeros(Int64, length(hands)),
    bid = bids
    )

## fill different cards in hand with the card strength rankings defined in Dictionary card_strength_rank
for i in 1:length(hands) 

    hand = split(hands[i], "")

    df.card1[i] = card_strength_rank[string(hand[1])]
    df.card2[i] = card_strength_rank[string(hand[2])]
    df.card3[i] = card_strength_rank[string(hand[3])]
    df.card4[i] = card_strength_rank[string(hand[4])]
    df.card5[i] = card_strength_rank[string(hand[5])]

end

## collect information about duplicate/multiplicate cards and special case fullhouse


for i in 1:length(hands)

    counts = collect(values(count_cards(hands[i])))

    subset_df = deepcopy(df[i,:])
    hand = collect(subset_df[3:7])
    
    ## duplicates
    duplicates = sum([counts[j] == 2 for j in 1:length(counts)])
    ## triplicates
    triplicates = sum([counts[j] == 3 for j in 1:length(counts)])
    ## quadruplicate
    quadruplicate = sum([counts[j] == 4 for j in 1:length(counts)])
    ## fiveruplicate
    fiveruplicate = sum([counts[j] == 5 for j in 1:length(counts)])
    
    ## alterate number of multiplicates according to number of jokers
    joker = count(x -> x == 1, hand)
    
    if joker == 4

        duplicates = 0
        triplicates = 0
        quadruplicate = 0
        fiveruplicate = 1

    elseif joker == 3

        triplicates -= 1 # joker dont count as multiplicates by themselves

        if duplicates == 1

            duplicates = 0
            triplicates = 0
            quadruplicate = 0
            fiveruplicate = 1
        else

            duplicates = 0
            triplicates = 0
            quadruplicate = 1
        end

    elseif joker == 2

        duplicates -= 1 # joker dont count as multiplicates by themselves

        if triplicates == 1

            duplicates = 0
            triplicates = 0
            quadruplicate = 0
            fiveruplicate = 1

        elseif duplicates >= 1  

            duplicates = 0
            triplicates = 0
            quadruplicate = 1

        elseif duplicates == 0  # the joker pair is the only duplicate

            duplicates = 0
            triplicates = 1
        end

    elseif joker == 1

        if quadruplicate == 1

            quadruplicate = 0
            fiveruplicate = 1

        elseif triplicates == 1

            triplicates = 0
            quadruplicate = 1
            
        elseif duplicates >= 1

            duplicates = duplicates - 1
            triplicates = 1
        
        elseif duplicates == 0

            duplicates = 1

        end

    elseif joker == 0

    ## Do nothing and continue to the next iteration 
 
    end
            
        
    ## fullhouse
    fullhouse = 0
    if duplicates == 1 && triplicates == 1
        fullhouse = 1
        duplicates = 0
        triplicates = 0
    end

    
    df.duplicate[i] = duplicates
    df.triplicate[i] = triplicates
    df.quadruplicate[i] = quadruplicate
    df.fiveruplicate[i] = fiveruplicate
    df.fullhouse[i] = fullhouse
    
    
    
end
    
df


## 4. Determine rank of players based on multiplcate with 5>4>fullhouse>3>2>highcard (counting order from card1 to 5)
   
## create scores based on weighted conditions

df.score .= 0
for i in 1:nrow(df)

    if df[i,:].fiveruplicate == 1
        df[i,:].score += 7
     elseif df[i,:].quadruplicate == 1
        df[i,:].score += 6
     elseif df[i,:].fullhouse == 1
        df[i,:].score += 5
     elseif df[i,:].triplicate == 1
        df[i,:].score += 4
     elseif df[i,:].duplicate == 2
        df[i,:].score += 3
     elseif df[i,:].duplicate == 1
        df[i,:].score += 2
    end
end

## sort by conditions and use high cards to resolve equal scores
sort!(df, :score, rev = true)

## multiply scores by 100 so I can add the Integer values of card1 to tied scores without shifting total scores
df.score = df.score * 100
## add weights of heigh cards1 to scores
df.score = df.score + df.card1

## multiply scores by 100 again so if there are still any ties they can be resolved by adding the weights of cards2 but dont bias the scores of untied cards
df.score = df.score * 100
## add weights of heigh cards1 to scores
df.score = df.score + df.card2

## repeat the multiplying score adding steps till card 5 is reached to be safe
df.score = df.score * 100
df.score = df.score + df.card3

df.score = df.score * 100
df.score = df.score + df.card4

df.score = df.score * 100
df.score = df.score + df.card5

## sort cards again and rank them
sort!(df, :score)

df.rank = 1:nrow(df)

## get results 
df.winnings = df.rank .* df.bid

sum(df.winnings)
