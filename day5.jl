cd("/Users/patricklauer/Documents/GitHub/advent_of_code_2023/")

input = read("day5_input.txt", String) 

sections = split(input, r"\n\n")

# Function to parse the seeds section
function parse_seeds(section::String)
    lines = split(section, "\n")
    seeds = parse.(Int, split(strip(lines[1])[8:end], " "))
    return seeds
end

# Function to parse a map section
function parse_map(section::String)
    lines = split(section, "\n")[2:end]  # Skip the first line
    map_data = [parse.(Int, split(line, " ")) for line in lines]
    return map_data
end

seeds = parse(sections[1])