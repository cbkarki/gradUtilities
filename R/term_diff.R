#' Calculate number of terms between two given terms.
#'
#' @description
#' This function calculates the number of academic terms between a `start_term`
#' and an `end_term`. It assumes a standard academic year with three terms
#' (Fall, Spring, Summer), where terms are represented by a four-digit year
#' followed by a two-digit term code (e.g., '202310' for Spring 2023, '202320'
#' for Summer 2023, and '202330' for Fall 2023). This is particularly useful
#' for calculating the elapsed time in terms between a student's enrollment and
#' graduation.
#'
#' The calculation is inclusive of both the start and end terms.
#'
#' @param start_term A numeric or character scalar representing the starting
#'   term. The format must be `YYYYTT`, where `YYYY` is the year and `TT` is the
#'   term code (10, 20, or 30).
#' @param end_term A numeric or character scalar representing the ending term.
#'   The format must be `YYYYTT`, where `YYYY` is the year and `TT` is the
#'   term code (10, 20, or 30).
#'
#' @return An integer representing the total number of terms between (and
#'   including) the `start_term` and `end_term`.
#'
#' @examples
#' # Calculate the number of terms between Fall 2022 and Spring 2023
#' term_diff(start_term = 202230, end_term = 202310)
#'
#' # Calculate the number of terms for a student who enrolled in Spring 2020
#' # and graduated in Fall 2023
#' term_diff(start_term = 202010, end_term = 202330)
#'
#' # function can also takes vectors of terms
#' # it is ok use an single term as the argument in end_term, because multiple students can graduate
#' # at the same term regardless of their starting term
#' start_term = c(202010,202020)
#' end_term = c(202510)
#' term_diff(start_term,end_term)
#'
#'start_term = c(202010,201920, 201030, 202410)
#'end_term = c(202510,202430,201130, 202410)
#' term_diff(start_term,end_term)
#'
#' # if the end_term and start_term arguments different lengths with an exception of single end_term,
#' # there will be an error
#'  start_term = c(202010,201920)
#' end_term = c(202510,202430,202510)
#' term_diff(start_term,end_term)

#' start_term = c(202010,201920,202510)
#'end_term = c(202510,202430)
#' term_diff(start_term,end_term)

#' @export

term_diff =
    function(start_term, end_term) {

    if (length(end_term) > 1 & (length(start_term) != length(end_term))) {
        stop("For end_term more then one entrires, it is required to have same amout of entries in start_term and end_term, otherwise the
             end_term will be recycled and results will be inconsistant.")
    }
    # Convert terms to numeric values for year and term part
    start_year <- as.numeric(substr(start_term, 1, 4))
    start_term_part <- as.numeric(substr(start_term, 5, 6))

    end_year <- as.numeric(substr(end_term, 1, 4))
    end_term_part <- as.numeric(substr(end_term, 5, 6))

    # Calculate year difference
    year_diff <- end_year - start_year

    # Map term parts (10, 20, 30) to month equivalents (e.g., 1, 4, 7 for simplicity in calculation)
    # This assumes 3 terms per year.
    map_term_to_index <- function(term_part) {
        # Using a numeric mapping where 10=1, 20=2, 30=3
        ifelse(term_part == 10, 1, ifelse(term_part == 20, 2, 3))
    }

    start_index <- map_term_to_index(start_term_part)
    end_index <- map_term_to_index(end_term_part)

    # Calculate total term difference.
    # The (start_index - 1) makes the count inclusive from the start term to the end term.
    total_terms <- (year_diff * 3) + (end_index - start_index) + 1

    return(total_terms)
}
