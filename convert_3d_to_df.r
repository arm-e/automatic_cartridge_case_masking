# Load required libraries
library(x3ptools)
library(feather)

# Get the current working directory
current_directory <- getwd()

# Set the path for the original data
file_path <- file.path(current_directory, "data", "original")

# Set the path for the intermediate data
out_path <- file.path(current_directory, "data", "intermediate/")
print(out_path)

# List all X3P files in the specified directory
x3p_files <- list.files(path = file_path, pattern = "\\.x3p$", full.names = TRUE)

# Process each X3P file
for (file_path in x3p_files) {
    # Read X3P file
    logo <- read_x3p(file_path)

    # Convert X3P data to a data frame
    logo_df <- x3p_to_df(logo)

    # Extract the file name without extension
    file_name <- tools::file_path_sans_ext(basename(file_path))

    # Write the data frame to Feather format in the intermediate directory
    write_feather(logo_df, file.path(out_path, paste0(file_name, ".feather")))
}
