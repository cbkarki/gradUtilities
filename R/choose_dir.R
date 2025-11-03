#' Choose a directory with tcltk, forcing dialog to front
#'
#' This function opens a tcltk directory chooser and ensures it appears in front of other windows.
#'
#' @return A string containing the selected directory path, or NA if cancelled.
#'
#' @importFrom tcltk tktoplevel tkwm.withdraw tk_choose.dir tkdestroy
choose_directory_tcltk <- function() {
    if (!requireNamespace("tcltk", quietly = TRUE)) {
        stop("The 'tcltk' package is required but not available on this system.")
    }

    tt <- tcltk::tktoplevel()
    tcltk::tkwm.withdraw(tt)  # Hide the dummy window
    dir <- tcltk::tk_choose.dir(caption = "Please choose a folder")
    tcltk::tkdestroy(tt)

    return(dir)
}
