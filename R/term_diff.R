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
#' start_term = c(202010,202020)
#' end_term = c(202510)
#' term_diff(start_term,end_term)
#'
#'  start_term = c(202010,201920)
#' end_term = c(202510,202430)
#' term_diff(start_term,end_term)
#' @export

term_diff <- Vectorize(
    function(start_term, end_term) {

        # term codes
        tt = c(10, 20, 30)
        yy = as.numeric(substr(start_term, 1, 4)):as.numeric(substr(end_term, 1, 4))

        # sequence of terms and index
        tt_seq =  paste0(rep(yy, each = 3), tt)

        # start index
        start_ind = which(tt_seq == start_term)

        # end index
        end_ind = which(tt_seq == end_term)

        # term diff
        term_elapsed = (end_ind - start_ind) + 1 # +1 for making it inclusive

        return(term_elapsed)
    },
    vectorize.args = c("start_term", "end_term")
)

