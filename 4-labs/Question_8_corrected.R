
# INCORRECT VERSION
# This code tries to use sapply directly outside mutate(), which returns a vector.
# As a result, it replaces the entire dataset with a character vector and breaks the pipeline.

netflix <- netflix %>%
  filter(type == "Movie", !is.na(duration), !is.na(listed_in)) %>%
  mutate(duration_mins = parse_number(duration),
         main_genre = str_split(listed_in, ",")) %>%
  sapply(`[`, 1) %>%              # Wrong-sapply applied to the entire dataframe!
  str_trim()

# This overwrites the dataframe 'netflix' with a character vector, this was the reason for errors like 
#"Error in View : no applicable method for 'separate_rows' applied to an object of class "character" " 

# causes downstream functions like filter(), ggplot(), etc., to fail.

 
# CORRECT VERSION
# Instead, do the transformation *inside* mutate(), column by column:

netflix <- netflix %>%
  filter(type == "Movie", !is.na(duration), !is.na(listed_in)) %>%
  mutate(
    duration_mins = parse_number(duration),
    main_genre = str_split(listed_in, ",")  %>%  sapply(`[`, 1)  %>%  str_trim()
  )

# Now 'main_genre' is properly created as a new column in the dataframe.
# The dataset structure is preserved and usable for further analysis/plotting.


#To fix broken pipeline - check if your dataframe got overwritten as a character string. 
#delete your environment, and reload your dataset. 