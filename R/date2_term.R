#' date2_term
#' @description
#' This function will convert given Date to term either the term code or the term description based on the pick of the user.
#'
#' @param date a date to be converted into term. Please phrase your date before you supply it to the function.
#' @param term an option to choose if term code is needed or the term description. Default is \code{"code"}. For term description supply \code{term="desc"}
#'
#' @importFrom dplyr case_when %>%
#' @importFrom lubridate year month
#'
#' @examples
#' # example 1
#' date1 = as.Date("2025-10-16")
#' date2_term(date1,"code")
#' date2_term(date1,"desc")
#'
#' # example 2
#' df = data.frame(date = c("2025-10-16","2025-1-29","2025-7-16"))
#'
#' df %>%
#' dplyr::mutate(term_code = date2_term(date,"code"),
#' term_desc = date2_term(date,"desc"))
#'
#' @author
#' Chitra Karki \email{cbkarki@miners.utep.edu}
#' Data Science Program, Mathematical Sciences,
#' University of Texas at El Paso,
#' Graduate School
#'@export
#'

date2_term = function(date,term = c("code","desc")) {
 term_code = case_when(month(date) < 6 ~ paste0(year(date),20),
                  month(date) < 9 ~ paste0(year(date),30),
                  month(date) < 13 ~ paste0(year(date)+1,10)
                  )
 if(term == "code") {
     return(term_code)
 } else if (term == "desc") {
         return(term_desc(term_code))
     }


 return(term_code)
}

