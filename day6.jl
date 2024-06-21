## Read input
cd("/Users/patricklauer/Documents/GitHub/advent_of_code_2023/")
input = readlines("day6_input.txt")

## Create time vector    
time = input[1] 
time = replace(time, "Time: " => "")
time = parse.(Int, split(time))

## Create distance vector
distance = input[2] 
distance = replace(distance, "Distance: " => "")
distance = parse.(Int, split(distance))


distance_partB = deepcopy(distance)
distance_partB = parse(Int64, join(string.(distance_partB)))

time_partB = deepcopy(time)
time_partB = parse(Int64, join(string.(time_partB)))

## Part A

## loop through all the runs
## loop through milliseconds per run
## calculate distance per time span button holding
## compare with record distance of run
## count up win possibilities
## multiply the win possiblities of all runs


## PartB

## Transform distance and time to one pasted integer
## and feed to the loop described in outline for PartA



## Result Loop

runs = length(time_partB)
wins = zeros(Int, length(time_partB))
for i in 1:runs

   milliseconds = time_partB[i]

   for speed in 0:milliseconds

        dist_achieved = (milliseconds - speed) * speed # Δpushbutton = speed

        if dist_achieved > distance_partB[i]
            wins[i] += 1
        end
    end
end

prod(wins)



