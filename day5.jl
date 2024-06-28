## 1. put input in seperate vectors for each conversion
## 2. create conversion sequences and save all information in convenient data structure 
## 3. convert seeds and find lowest end location value


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

## 2. store information of source ranges in dataframe (1 df for each conversion)

## clean up by writing function!!

using DataFrames

## seed to soil

df_seed_to_soil = DataFrame(conversion = [],
               source_start = [],
               source_end = [],
               destination_start =[],
               destination_end = [])

for i in 1:length(seed_to_soil)

    source_range = range(seed_to_soil[i][2], length = seed_to_soil[i][3])
    corresponding_destination = range(seed_to_soil[i][1], length = seed_to_soil[i][3])
    
    if length(source_range) == 1 ## if range only includes 1 location
        source_start = source_range[1]
        source_end = source_range[1]

        destination_start = corresponding_destination[1]
        destination_end = corresponding_destination[1]

    
    else
        source_start = source_range[1]
        source_end = source_range[end]

        destination_start = corresponding_destination[1]
        destination_end = corresponding_destination[end]
    end

    temp =  DataFrame(conversion = "seed_to_soil",
    source_start = source_start,
    source_end = source_end,
    destination_start = destination_start,
    destination_end = destination_end)
    
    df_seed_to_soil = vcat(df_seed_to_soil, temp)
end



## soil to fertilizer

df_soil_to_fertilizer = DataFrame(conversion = [],
               source_start = [],
               source_end = [],
               destination_start =[],
               destination_end = [])

for i in 1:length(soil_to_fertilizer)

    source_range = range(soil_to_fertilizer[i][2], length = soil_to_fertilizer[i][3])
    corresponding_destination = range(soil_to_fertilizer[i][1], length = soil_to_fertilizer[i][3])
    
    if length(source_range) == 1 ## if range only includes 1 location
        source_start = source_range[1]
        source_end = source_range[1]

        destination_start = corresponding_destination[1]
        destination_end = corresponding_destination[1]

    
    else
        source_start = source_range[1]
        source_end = source_range[end]

        destination_start = corresponding_destination[1]
        destination_end = corresponding_destination[end]
    end

    temp =  DataFrame(conversion = "soil_to_fertilizer",
    source_start = source_start,
    source_end = source_end,
    destination_start = destination_start,
    destination_end = destination_end)
    
    df_soil_to_fertilizer = vcat(df_soil_to_fertilizer, temp)
end


## fertilizer_to_water
df_fertilizer_to_water = DataFrame(conversion = [],
               source_start = [],
               source_end = [],
               destination_start =[],
               destination_end = [])

for i in 1:length(fertilizer_to_water)

    source_range = range(fertilizer_to_water[i][2], length = fertilizer_to_water[i][3])
    corresponding_destination = range(fertilizer_to_water[i][1], length = fertilizer_to_water[i][3])
    
    if length(source_range) == 1 ## if range only includes 1 location
        source_start = source_range[1]
        source_end = source_range[1]

        destination_start = corresponding_destination[1]
        destination_end = corresponding_destination[1]

    
    else
        source_start = source_range[1]
        source_end = source_range[end]

        destination_start = corresponding_destination[1]
        destination_end = corresponding_destination[end]
    end

    temp =  DataFrame(conversion = "fertilizer_to_water",
    source_start = source_start,
    source_end = source_end,
    destination_start = destination_start,
    destination_end = destination_end)
    
    df_fertilizer_to_water = vcat(df_fertilizer_to_water, temp)
end

## water_to_light
df_water_to_light = DataFrame(conversion = [],
               source_start = [],
               source_end = [],
               destination_start =[],
               destination_end = [])

for i in 1:length(water_to_light)

    source_range = range(water_to_light[i][2], length = water_to_light[i][3])
    corresponding_destination = range(water_to_light[i][1], length = water_to_light[i][3])
    
    if length(source_range) == 1 ## if range only includes 1 location
        source_start = source_range[1]
        source_end = source_range[1]

        destination_start = corresponding_destination[1]
        destination_end = corresponding_destination[1]

    
    else
        source_start = source_range[1]
        source_end = source_range[end]

        destination_start = corresponding_destination[1]
        destination_end = corresponding_destination[end]
    end

    temp =  DataFrame(conversion = "water_to_light",
    source_start = source_start,
    source_end = source_end,
    destination_start = destination_start,
    destination_end = destination_end)
    
    df_water_to_light = vcat(df_water_to_light, temp)
end

## light_to_temperature
df_light_to_temperature = DataFrame(conversion = [],
               source_start = [],
               source_end = [],
               destination_start =[],
               destination_end = [])

for i in 1:length(light_to_temperature)

    source_range = range(light_to_temperature[i][2], length = light_to_temperature[i][3])
    corresponding_destination = range(light_to_temperature[i][1], length = light_to_temperature[i][3])
    
    if length(source_range) == 1 ## if range only includes 1 location
        source_start = source_range[1]
        source_end = source_range[1]

        destination_start = corresponding_destination[1]
        destination_end = corresponding_destination[1]

    
    else
        source_start = source_range[1]
        source_end = source_range[end]

        destination_start = corresponding_destination[1]
        destination_end = corresponding_destination[end]
    end

    temp =  DataFrame(conversion = "light_to_temperature",
    source_start = source_start,
    source_end = source_end,
    destination_start = destination_start,
    destination_end = destination_end)
    
    df_light_to_temperature = vcat(df_light_to_temperature, temp)
end

## temperature_to_humidity
df_temperature_to_humidity = DataFrame(conversion = [],
               source_start = [],
               source_end = [],
               destination_start =[],
               destination_end = [])

for i in 1:length(temperature_to_humidity)

    source_range = range(temperature_to_humidity[i][2], length = temperature_to_humidity[i][3])
    corresponding_destination = range(temperature_to_humidity[i][1], length = temperature_to_humidity[i][3])
    
    if length(source_range) == 1 ## if range only includes 1 location
        source_start = source_range[1]
        source_end = source_range[1]

        destination_start = corresponding_destination[1]
        destination_end = corresponding_destination[1]

    
    else
        source_start = source_range[1]
        source_end = source_range[end]

        destination_start = corresponding_destination[1]
        destination_end = corresponding_destination[end]
    end

    temp =  DataFrame(conversion = "temperature_to_humidity",
    source_start = source_start,
    source_end = source_end,
    destination_start = destination_start,
    destination_end = destination_end)
    
    df_temperature_to_humidity = vcat(df_temperature_to_humidity, temp)
end

## humidity_to_location
df_humidity_to_location = DataFrame(conversion = [],
               source_start = [],
               source_end = [],
               destination_start =[],
               destination_end = [])

for i in 1:length(humidity_to_location)

    source_range = range(humidity_to_location[i][2], length = humidity_to_location[i][3])
    corresponding_destination = range(humidity_to_location[i][1], length = humidity_to_location[i][3])
    
    if length(source_range) == 1 ## if range only includes 1 location
        source_start = source_range[1]
        source_end = source_range[1]

        destination_start = corresponding_destination[1]
        destination_end = corresponding_destination[1]

    
    else
        source_start = source_range[1]
        source_end = source_range[end]

        destination_start = corresponding_destination[1]
        destination_end = corresponding_destination[end]
    end

    temp =  DataFrame(conversion = "humidity_to_location",
    source_start = source_start,
    source_end = source_end,
    destination_start = destination_start,
    destination_end = destination_end)
    
    df_humidity_to_location = vcat(df_humidity_to_location, temp)
end

## 3. find locations for seeds

## function that converts seed from 1 category to the next by looping through converion ranges and transforming seeds if a matching range is found
conversion = function(df, seed)
   
    ## when not in range transformed seed stays the same
    seed_transformed = seed
   
    for j in 1:nrow(df) 
 
         ## if the seed is in range convert it to destination location
         if seed >= df[j,:].source_start && seed <= df[j,:].source_end
 
             ## conversion factor
             conversion_factor = df[j,:].source_start - df[j,:].destination_start
 
            seed_transformed = seed - conversion_factor
         
             ## if not in range continue
         else 
            
         end
     end

     return seed_transformed
end


final_location = []

## loop through seeds and perform converion for every category 
for i in 1:length(seeds)

    seed = seeds[i]
   
    ## seed to soil

   seed = conversion(df_seed_to_soil, seed)

    ## soil to fertilizer
   
    seed = conversion(df_soil_to_fertilizer, seed)

      ## fertilizer to water
  
      seed = conversion(df_fertilizer_to_water, seed)

    ## water to light

    seed = conversion(df_water_to_light, seed)

     ## light to temperature
   
     seed = conversion(df_light_to_temperature, seed)

     ## temperature to humidity

     seed = conversion(df_temperature_to_humidity, seed)

     ## humidity to location

     seed = conversion(df_humidity_to_location, seed)

     push!(final_location, seed)


end

minimum(final_location)


## Part B

## separte seeds vector by even and odd indexes
start = [value for (index, value) in enumerate(seeds) if index % 2 != 0]
ranges = [value for (index, value) in enumerate(seeds) if index % 2 == 0]

seeds_partB = collect(range(start[1], length = ranges[1]))
for i in 2: length(start)

   vcat(seeds_partB, collect(range(start[i], length = ranges[i])))

end

## loop through seeds and perform converion for every category 

final_location = []

for i in 1:length(seeds_partB)

    seed = seeds_partB[i]
   
    ## seed to soil

   seed = conversion(df_seed_to_soil, seed)

    ## soil to fertilizer
   
    seed = conversion(df_soil_to_fertilizer, seed)

      ## fertilizer to water
  
      seed = conversion(df_fertilizer_to_water, seed)

    ## water to light

    seed = conversion(df_water_to_light, seed)

     ## light to temperature
   
     seed = conversion(df_light_to_temperature, seed)

     ## temperature to humidity

     seed = conversion(df_temperature_to_humidity, seed)

     ## humidity to location

     seed = conversion(df_humidity_to_location, seed)

     push!(final_location, seed)


end