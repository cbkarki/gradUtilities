#' Summarize a Data Frame's Structure and Content
#'
#' Generates a comprehensive summary data frame detailing each column's name,
#' type, missing values (count and percentage), number of unique values,
#' and basic descriptive statistics (mean, median, min, max) for numeric columns.
#'
#' @param file A data frame that you want to summarize.
#'
#' @return A data frame containing summary statistics for each column of the input 'file'.
#'   Columns in the output data frame are:
#'   \itemize{
#'     \item SN: Serial Number/Index
#'     \item Names: Column names from the input data frame
#'     \item Col_Type: Data type/class of the column (e.g., "numeric", "character")
#'     \item NA_Count: Total count of missing values
#'     \item NA_Per: Percentage of missing values
#'     \item Unique_Values: Count of unique values in the column
#'     \item Mean: Mean value (NA for non-numeric columns)
#'     \item Median: Median value (NA for non-numeric columns)
#'     \item Min: Minimum value (NA for non-numeric columns)
#'     \item Max: Maximum value (NA for non-numeric columns)
#'   }
#' @export
#'
#' @examples
#' # Example using the built-in 'iris' dataset
#'  summarize_dataframe(iris)
#'
#' # Example with mixed data types
#'  test_data <- data.frame(
#'    id = 1:10,
#'    name = letters[1:10],
#'    value = c(1, 2, NA, 4, 5, 6, 7, NA, 9, 10)
#'  )
#'  summarize_dataframe(test_data)
summarize_dataframe = function(file) {
    n_col  = ncol(file)
    df = data.frame("SN" = 1:n_col,
                    "Names" = names(file),
                    "Col_Type" = sapply(file,class),
                    "NA_Count" =  colSums(is.na(file)),
                    "NA_Per" =  (colSums(is.na(file))/nrow(file)) * 100,
                    "Unique_Values" = sapply(file,FUN = function (x) {length(unique(x))})
    )
    # adding basic stats for numeric columns only
    for (i in 1:n_col) {
        if (is.numeric(file[[i]])) {
            df$Mean[i] = mean(file[[i]], na.rm = TRUE)
            df$Median[i] = median(file[[i]], na.rm = TRUE)
            df$Min[i] = min(file[[i]], na.rm = TRUE)
            df$Max[i] = max(file[[i]], na.rm = TRUE)
        } else {
            df$Mean[i] = NA
            df$Median[i] = NA
            df$Min[i] = NA
            df$Max[i] = NA
        }
    }
    row.names(df) = NULL
    cat("Rows:", nrow(file), ", Columns:", ncol(file), "\n")

    return(df)
}
