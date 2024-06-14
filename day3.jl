## 1. format as matrix
## 2. loop through each entry and check for neighbors
## 3. create second matrix that saves information if neighbors are anything other than "." or a number
## 4. compare neighborinfo matrix with input matrix and keep every number that has a symbol as neighbor as well as the numbers next to that particular number

cd("/Users/patricklauer/Documents/GitHub/advent_of_code_2023/")
using DelimitedFiles
engine = readdlm("day3_input.txt", '\n')


## 1. Transform input to a matrix

# Determine the size of the matrix
n_rows = length(engine)
n_cols = length(engine[1])

# Initialize an empty matrix of characters
matrix = Array{Char}(undef, n_rows, n_cols)

# Fill the matrix with characters from the input strings
for i in 1:n_rows
    for j in 1:n_cols
        matrix[i, j] = engine[i][j]
    end
end


## 2. Loop through input matrix, check neighboring values
## 3. and store in  neighor information matrix

##neighbor information matrix, zero as default will be replaced with 1 (in loop below) if there is a symbol neighbor
symbol_neighor = zeros(Int64, n_rows, n_cols)

## function that puts out neigboring values for entry i,j
function get_adjacent_entries(matrix, i, j)
    rows, cols = size(matrix)
    adjacent_entries = []
    
    for di in -1:1
        for dj in -1:1
            if di == 0 && dj == 0
                continue  
            end
            ni, nj = i + di, j + dj
            if 1 <= ni <= rows && 1 <= nj <= cols
                push!(adjacent_entries, matrix[ni, nj])
            end
        end
    end
    
    return adjacent_entries
end

## define number vector to compare matrix with
numbers = ['0','1','2','3','4','5','6','7','8','9']

for i in 1:length(matrix[:,1])
    for j in 1:length(matrix[1,:])

        if matrix[i,j] in numbers

            adjacent = get_adjacent_entries(matrix, i, j)
            
            ## filter out neighbors that are entries other than numbers or '.'
            symbols = setdiff(Set(adjacent), numbers)
            symbols = setdiff(symbols, '.')

            if length(symbols) > 0
                ## if a number has a symbol as neighbor set the matrix symbol_neigbor to 1
                symbol_neighor[i,j] = 1
            end

        end

    end
end

## 4. compare information of symbol neighbors with input matrix
## and filter for numbers and there adjacent numbers that have a symbol neighbor

## function to create a n digit number based on the numbers left and right to the focal number
function get_numbers_beside(matrix, i, j)
    rows, cols = size(matrix) # length of rows and cols
     number = matrix[i,j] # focal number 
     seq_dj = (-1, -2, 1, 2) # sequence to loop through neighbors (we want the number 1 to the left be added before the second to the left)
    for dj in (seq_dj)
            nj = j + dj
            if  1 <= nj <= cols 
                if matrix[i,nj] in numbers

                    if dj <= -1 && matrix[i, nj+1] in numbers ## only add this value to the left of our number if it is located to the left and if the next-left value is also a number
                        number = matrix[i,nj] * number
                    end
                    if dj >= 1 && matrix[i, nj- 1] in numbers ## only add this value to the right of our number if it is located to the right and if the next-right value is also a number
                        number = number * matrix[i,nj]
                    end

                end
            end
    end 
    return number
end

## get results

result = ["filler"] ## create filler as starting value

## keep track of the vertical and horizontal positions
horizontal_position_number = [0]
vertical_position_number = [0]
for i in 1:length(matrix[:,1])
    for j in 1:length(matrix[1,:])

        if symbol_neighor[i,j] == 1
            
            temp = get_numbers_beside(matrix, i, j)
            temp = string.(temp) # reformat numbers, this is needed for 1 digit numbers as they are in this weird format: SCII/Unicode U+0032 (
            
            if  j - last(horizontal_position_number) >= 2 || i != last(vertical_position_number)  # only include number if the previous created number is not located directly next to it (to avoid duplicated numbers created by 2 digits next to symbol)
             push!(result, temp)
            end
            push!(horizontal_position_number, j)
            push!(vertical_position_number, i)
        end
    end
end

## remove filler value at start
result = filter!(x -> x != "filler", result)

## sum up all numbers
sum(parse.(Int64, result))


