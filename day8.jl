using DelimitedFiles
cd("/Users/patricklauer/Documents/GitHub/advent_of_code_2023/")
lines = readdlm("day8_input.txt") 

## seperate directions
directions = lines[1]
directions = collect(directions)
## seperate and clean map information
map = lines[2:end,:]
map = map[:, [1,3,4]]

function remove_symbols(matrix)
    return replace(matrix, r"[\(,\)]" => "")
end

map[:,2] = remove_symbols.(map[:,2])
map[:,3] = remove_symbols.(map[:,3])

map
## first column = location
## second column = location if left step
## third column = location if right step    


##while loop through matrix till it reaches ZZZ and keep track of steps
directions = repeat(directions, 100) 
location = "AAA"
steps = 0

while location != "ZZZ"

    i = findfirst( x -> x == 1, map[:,1] .== location) ## find the row in which the correct location is in the matrix

    if directions[steps+1] == 'L'

        location = map[i,2]
        steps += 1

    elseif directions[steps+1] == 'R'
    
        location = map[i,3]
        steps += 1
    end
end