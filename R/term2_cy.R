
#' Term codes to Calander Year
#' @description
#' Converts term code to Calander year. For instance, terms 202520,202530 202610 belong to Calander Year 2025.
#'
#' @param term a numeric/character value of the term code.
#'
#' @examples
#' # example 1
#'  term = c("202510", "202520")
#'  term2_cy(term)
#'
#'  # example 2
#'
#' df = data.frame(sn = 1:4,term = c(201120, 202010, 202530, 202420))
#' df %>%
#'    mutate(CA = term2_cy(term))
#'
#' @author
#' Chitra Karki \email{cbkarki@miners.utep.edu}
#' Data Science Program, Mathematical Sciences,
#' University of Texas at El Paso,
#' Graduate School
#'
#' @return Returns the respective Calander Years to which the supplied terms via function argument.
#'
#' @export

term2_cy = function(term) {

    if(all(nchar(term)  != 6)) {
        stop("term should be of 6 character long !!")
    } else {
        cy = ifelse(substr(term,5,6) == "10",
                    as.numeric(substr(term,1,4)) - 1,
                    substr(term,1,4))

    }

    return(cy)
}



