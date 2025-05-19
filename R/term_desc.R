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
