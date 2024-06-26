

## return the slope of the sequence of y
change = function(y) 
       
    dy = Int[]
    for i in 1:length(y) -1
        
        temp = y[i+1] - y[i]
        push!(dy, temp)
    end
    return dy
end

## load in data
using DelimitedFiles
cd("/Users/patricklauer/Documents/GitHub/advent_of_code_2023/")
lines = readdlm("day9_input.txt") 

next_number = Int[]

## loop through all sequences of numbers
for l in 1:size(lines, 1) 

    y = [Int64(I) for I in lines[l,:]]  # convert floats to Integers

    ## add the derivative sequence till the slope is 0
    dy = change(y)
    y = [y, dy]
    j = 2
    while sum(dy) != 0

            dy = change(y[j])
            push!(y, dy)

        j += 1

    end

    ## add the new predicted value by going through all end values of the sequence and add the slope (begin with the last non-zero derivative)
    for i in reverse(1:length(y)-1)
        new = y[i][end] + y[i+1][end]
        push!(y[i], new)
    end

    ## save the predicted next number from y sequence
    next_number = push!(next_number, y[1][end])
end

sum(next_number)
## wrong solution
## dont know what is causing it, works with sample example

