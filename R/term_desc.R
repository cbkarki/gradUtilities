#' Term codes to term description
#' @description
#' This function converts given term codes into term description. For instance, the terms: 202510,202520, 202530 would be described as
#' Fall 2024, Spring 2025 and Summer 2025, respectively.
#'
#' @param term  a six character long term code, e.g. \code{"202510"}. It accepts both interger or character type parameter
#'
#' @author
#' Chitra Karki \email{cbkarki@miners.utep.edu}
#' Data Science Program, Mathematical Sciences,
#' University of Texas at El Paso,
#' Graduate School
#'
#' @examples
#' # example 1
#' term = c(202510,202520, 202530)
#' term_desc(term)
#'
#' # example 2
#' term = c("202510",202520, 202530)
#' term_desc(term)
#'
#' # example 3
#' df = data.frame(term = c(202510,202520, 202530))
#' df %>%
#' dplyr::mutate(term_desc = term_desc(term))
#'
#'@export
term_desc = Vectorize(
    function(term) {
        if(nchar(term) != 6) stop("Term needs to 6 character long !!")
        if(!is.character(term)) {
            term = as.character(term)
        }

        if(substr(term, 5, 6) == 20) {
            return(paste("Spring", substr(term, 1, 4), sep = " "))
            } else if (substr(term, 5, 6) == 30) {
                return(paste("Summer", substr(term, 1, 4), sep = " "))
                } else {
                    return(paste("Fall", as.numeric(substr(term, 1, 4)) - 1))
                }
        }
    )
