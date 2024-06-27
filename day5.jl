## 1. put input in seperate vectors for each conversion
## 2. create conversion sequences and save all information in convenient data structure 
## 3. find lowest end location value


## 1. clean up input and store different conversions in seperate vectors

cd("/Users/patricklauer/Documents/GitHub/advent_of_code_2023/")
input = read("day5_input.txt", String)

## Split  input data into categories based on double newlines
categories = split(input, "\n\n")

## convert seeds seperatly because it has a different format than other categories
seeds = replace(categories[1], "seeds: " => "")
seeds = parse.(Int, split(seeds))

## loop and clean the different conversion categories, store them seperately as vector of vectors 
for i in 2:length(categories)

  lines =  split(categories[i], "\n")

    # The first line is the title
    name = replace(lines[1], " map:" => "") 
    name = replace(name, "-" =>"_")
    
    # Initiate vector to store values that convert numbers from 1 category to the other
    
    conversion_map = []
    
    for j in 2:length(lines)
        # Split each line into individual numbers and convert to integers
        row_values = parse.(Int, split(lines[j]))
        push!(conversion_map, row_values)
    end
        
    ## create vector of vectors with dynamic names (for each category map)
    @eval begin
        global $(Symbol(name)) = conversion_map
    end
end

## inspect automatically created data structures
seeds
seed_to_soil
soil_to_fertilizer
fertilizer_to_water
water_to_light
light_to_temperature
temperature_to_humidity
humidity_to_location 
## 1 column = destination range start
## 2 column = source range start
## 3 range length

## 2. store all information in a DataFrame


## DOES NOT WORK, way to slow 
## INSTEAD ONLY SAVE MIN AND MAX OF EACH RANGE AND CHECK IF SEED IS WITHIN, convertion according to in whcih range the seed is using if else statements


## seed to soil

full_source_range = Int[]
full_destination = Int[]

#for i in 1:length(seed_to_soil)

    source_range = range(seed_to_soil[i][2], length = seed_to_soil[i][3])
    corresponding_destination = collect(range(seed_to_soil[i][1], length = seed_to_soil[i][3]))
    
    full_source_range = [full_source_range, source_range]
    full_destination = vcat(full_destination, corresponding_destination)
#end



## soil to fertilizer

full_source_range = Int[]
full_destination = Int[]

for i in 1:length(soil_to_fertilizer)


    source_range = collect(range(soil_to_fertilizer[i][2], length = soil_to_fertilizer[i][3]))
    corresponding_destination = collect(range(soil_to_fertilizer[i][1], length = soil_to_fertilizer[i][3]))
    
    full_source_range = vcat(full_source_range, source_range)
    full_destination = vcat(full_destination, corresponding_destination)
end

temp = DataFrame(conversion = "soil_to_fertilizer",
          source = full_source_range, 
          destination = full_destination)
           
df = vcat(df, temp)

## fertilizer_to_water

full_source_range = Int[]
full_destination = Int[]

for i in 1:length(fertilizer_to_water)

    source_range = collect(range(fertilizer_to_water[i][2], length = fertilizer_to_water[i][3]))
    corresponding_destination = collect(range(fertilizer_to_water[i][1], length = fertilizer_to_water[i][3]))
    
    full_source_range = vcat(full_source_range, source_range)
    full_destination = vcat(full_destination, corresponding_destination)
end

temp = DataFrame(conversion = "fertilizer_to_water",
          source = full_source_range, 
          destination = full_destination)
           
df = vcat(df, temp)

## water_to_light

full_source_range = Int[]
full_destination = Int[]

for i in 1:length(water_to_light)

    source_range = collect(range(water_to_light[i][2], length = water_to_light[i][3]))
    corresponding_destination = collect(range(water_to_light[i][1], length = water_to_light[i][3]))
    
    full_source_range = vcat(full_source_range, source_range)
    full_destination = vcat(full_destination, corresponding_destination)
end

temp = DataFrame(conversion = "water_to_light",
          source = full_source_range, 
          destination = full_destination)
           
df = vcat(df, temp)

## light_to_temperature

full_source_range = Int[]
full_destination = Int[]

for i in 1:length(light_to_temperature)

    source_range = collect(range(light_to_temperature[i][2], length = light_to_temperature[i][3]))
    corresponding_destination = collect(range(light_to_temperature[i][1], length = light_to_temperature[i][3]))
    
    full_source_range = vcat(full_source_range, source_range)
    full_destination = vcat(full_destination, corresponding_destination)
end

temp = DataFrame(conversion = "light_to_temperature",
          source = full_source_range, 
          destination = full_destination)
           
df = vcat(df, temp)

## temperature_to_humidity

full_source_range = Int[]
full_destination = Int[]

for i in 1:length(temperature_to_humidity)

    source_range = collect(range(temperature_to_humidity[i][2], length = temperature_to_humidity[i][3]))
    corresponding_destination = collect(range(temperature_to_humidity[i][1], length = temperature_to_humidity[i][3]))
    
    full_source_range = vcat(full_source_range, source_range)
    full_destination = vcat(full_destination, corresponding_destination)
end

temp = DataFrame(conversion = "temperature_to_humidity",
          source = full_source_range, 
          destination = full_destination)
           
df = vcat(df, temp)

## humidity_to_location

full_source_range = Int[]
full_destination = Int[]

for i in 1:length(humidity_to_location)

    source_range = collect(range(humidity_to_location[i][2], length = humidity_to_location[i][3]))
    corresponding_destination = collect(range(humidity_to_location[i][1], length = humidity_to_location[i][3]))
    
    full_source_range = vcat(full_source_range, source_range)
    full_destination = vcat(full_destination, corresponding_destination)
end

temp = DataFrame(conversion = "humidity_to_location",
          source = full_source_range, 
          destination = full_destination)
           
df = vcat(df, temp)

## 3. find locations for seeds

i = 1

final_location = []

for i in 1:length(seeds)

    df_sub = filter(row -> row.conversion == "seed_to_soil", df)
    ## if the seed is in range convert it to destination location
    if seeds[i] in df_sub.source

        seeds[i] = filter(row -> row.source == seeds[i], df_sub).destination[1]
    
        ## if not in range just leave the source value as the destination value 
    else 

    end

    df_sub = filter(row -> row.conversion == "soil_to_fertilizer", df)
    ## if the seed is in range convert it to destination location
    if seeds[i] in df_sub.source

        seeds[i] = filter(row -> row.source == seeds[i], df_sub).destination[1]
    
        ## if not in range just leave the source value as the destination value 
    else 

    end

    df_sub = filter(row -> row.conversion == "fertilizer_to_water", df)
    ## if the seed is in range convert it to destination location
    if seeds[i] in df_sub.source

        seeds[i] = filter(row -> row.source == seeds[i], df_sub).destination[1]
    
        ## if not in range just leave the source value as the destination value 
    else 

    end

    df_sub = filter(row -> row.conversion == "water_to_light", df)
    ## if the seed is in range convert it to destination location
    if seeds[i] in df_sub.source

        seeds[i] = filter(row -> row.source == seeds[i], df_sub).destination[1]
    
        ## if not in range just leave the source value as the destination value 
    else 

    end

    df_sub = filter(row -> row.conversion == "light_to_temperature", df)
    ## if the seed is in range convert it to destination location
    if seeds[i] in df_sub.source

        seeds[i] = filter(row -> row.source == seeds[i], df_sub).destination[1]
    
        ## if not in range just leave the source value as the destination value 
    else 

    end

    df_sub = filter(row -> row.conversion == "temperature_to_humidity", df)
    ## if the seed is in range convert it to destination location
    if seeds[i] in df_sub.source

        seeds[i] = filter(row -> row.source == seeds[i], df_sub).destination[1]
    
        ## if not in range just leave the source value as the destination value 
    else 

    end

    df_sub = filter(row -> row.conversion == "humidity_to_location", df)
    ## if the seed is in range convert it to destination location
    if seeds[i] in df_sub.source

        seeds[i] = filter(row -> row.source == seeds[i], df_sub).destination[1]
    
        ## if not in range just leave the source value as the destination value 
    else 

    end

    push!(final_location, seeds[i])

end

final_location