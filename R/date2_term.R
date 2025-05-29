#' Date to term
#' @description
#' This function will convert given Date to term
#'
#'@export
#'
#'@param date a date to be converted into term. Please phrase your date before you supply it to the function.
#'@param term an option to choose if term code is needed or the term description. Default is \code{"code"}. For term description supply \code{term="desc"}
#'
#'@importFrom dplyr case_when
#'@importFrom lubridate year month
#'
date2_term = function(date,term = "code") {
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

