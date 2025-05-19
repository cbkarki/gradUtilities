# this function converts given AY to the respective terms and the calander year

# ay2_term_ca = function(ay, to = c("term","termDes")) {
#
#     to = match.arg(to)
#
#     if (!grepl("-",ay) | nchar(ay) != 9
#         ) {
#         stop("ay should be character of length 9 !!")
#     } else if (nchar(ay) == 9 & (substr(ay, 1, 4) == substr(ay , 6, 9))) {
#         stop(" the years cann't be same")
#
#     } else if (nchar(ay) == 9 & substr(ay,5,5) != "-") {
#         stop(" \"-\" should be seperating two years !!")
#     } else {
#         if (to == "term") {
#             return(paste0(substr(ay,6,9),c(10,20,30)))
#         } else if (to == "termDes") {
#             return(print("so far so good"))
#
#         }
#     }
#
# }

#' term to term description
#' @description
#' Converts numeric term code to readable term descriptions
#'
#' @param term A numeric value or vector.
#' @export

term2_ay = function(term) {

    if(nchar(term) != 6) {
        stop("term should be of 6 character long !!")
    }

    ay = paste0(as.numeric(substr(term,1,4)) - 1, "-", substr(term,1,4))
    return(ay)
}

