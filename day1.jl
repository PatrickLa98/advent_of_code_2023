## Day 1

## Part A

# Function to form a 2-digit number from the first and last digit from vector strings
function form_two_digit_number(s)
    # Extract digits
    digits = filter(c -> isdigit(c), s)
    len = length(digits)
    
    # Form the 2-digit number based on the number of digits found
    
    # none found, omit it
    if len == 0
        return ""
    # one found, duplicate it    
    elseif len == 1
        return digits * digits
    # more than one found, take first and last digit     
    else
        return digits[1] * digits[end]
    end
end


# Open and read the file line by line
input = open("day1_input.txt", "r") do file
    readlines(file)
end

## Get results
result_A = [form_two_digit_number(s) for s in input] 
result_A = [parse(Int64, s) for s in result_A]

sum(result_A)

## Part B

## Define a Dictionary that translates spelled-out numbers to digits
## keep first and last latter in case there are mixed up spelled-digits e.g. threeight
spelled_to_digit = Dict(
    "one" => "o1e", "two" => "t2o", "three" => "t3e",
    "four" => "f4r", "five" => "f5e", "six" => "s6x", "seven" => "s7n",
    "eight" => "e8t", "nine" => "n9e"
)


## Define function that uses the Dictionary to replace spelled-out numbers with integer numbers
function transform_spelled_digits(s)
for(spelled, digit) in spelled_to_digit
s = replace(s, spelled => digit)
end
return s
end

## transform input to spelled-out input
input_transformed = [transform_spelled_digits(s) for s in input]
## run the transform twice to capture potential mixed up spelled-digits e.g. threeight
input_transformed = [transform_spelled_digits(s) for s in input_transformed]

## Get results
result_B = [form_two_digit_number(s) for s in input_transformed] 
result_B = [parse(Int64, s) for s in result_B]

sum(result_B)


