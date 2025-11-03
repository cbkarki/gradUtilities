#' Stack Data from Multiple Excel Sheets
#'
#' This function reads all sheets from an Excel file, skips a specified number of
#' initial rows for each sheet if provided, else skips 0 initial rows by default, and stacks them row-wise into a single
#' data frame. It also provides optional verbose output with dimensions of each sheet.All the tabs should contain same amount
#' of columns in them.
#'
#' @param path A character string. The path to the Excel (.xlsx or .xls) file.
#' @param skip A numeric value. The number of rows to skip from the beginning of
#'   each sheet before reading data. Defaults to 0.
#' @param verbose A logical value. If TRUE (default), prints the names, row count,
#'   and column count for each sheet, as well as the dimensions of the final
#'   consolidated data frame.
#'
#' @return A data frame containing the combined data from all sheets, stacked
#'   row-wise.
#'
#' @importFrom readxl excel_sheets read_excel
#' @export
#'
#' @examples
#' \dontrun{
#' # Example usage with a dummy path:
#' # Replace "C:/Users/..." with a valid path to an Excel file
#' file_path <- "C:/Users/.......xlsx"
#'
#' if (file.exists(file_path)) {
#'   stacked_data <- tabs_stack_xlsx(path = file_path, skip = 0)
#'   head(stacked_data)
#' } else {
#'   cat("Example file not found at the specified path.\n")
#' }
#' }
tabs_stack_xlsx = function(path, skip=0, verbose = TRUE) {

    sheet_names = readxl::excel_sheets(path)
    list_tabs = list()
    n_rows = n_cols = NULL

    for (i in 1:length(sheet_names)) {
        # Using readxl::read_excel to handle both .xlsx and .xls formats
        list_tabs[[i]] = readxl::read_excel(path,sheet = sheet_names[i],skip = skip)

        n_rows[i] = nrow(list_tabs[[i]])
        n_cols[i] = ncol(list_tabs[[i]])

    }
    ft_consolidated <- do.call(rbind, list_tabs)

    if(verbose) {
        # Using cat() and paste() with a newline separator for better formatting
        cat(paste("Sheet Name:",sheet_names,", No. rows = ",n_rows, ", No.cols = ",n_cols, collapse = "\n"))
        cat("\n","Dims of Consolidated file: ", dim(ft_consolidated), "\n") # Added newline for cleaner output
    }

    return(ft_consolidated)

}
