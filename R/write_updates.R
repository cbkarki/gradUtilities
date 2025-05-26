write_updates_csv = function(dat) {
    #ask user for input, if they want to write an csv output
    answer <- readline(prompt = "Write updates as csv? Y/N: ")

    if (toupper(answer) == "Y") {
        cat("\nSelect a directory to save the file.\n")
        dir_path <- tcltk::tk_choose.dir(default = getwd())

        if(is.na(dir_path) || dir_path == "") {stop("No directory selected. Please select a directory to save file")}

        filename <- readline(prompt = "Enter the filename (with .csv extensiopn): ")

        if(is.na(dir_path) || dir_path == "" || is.na(filename) || filename == "") {stop("No file name entered. Please enter file name!!")}

        # full path
        full_path <- file.path(dir_path,filename)
        # save file
        write.csv(dat, file = full_path, row.names = FALSE)
        cat("File saved at",full_path,"\n")
        cat("\n")
    } else if (toupper(answer) == "N") {
        cat("\n File not saved.\n Writing output to console: \n")
        print(dat,n=nrow(dat))
        cat("\n\nPlease make necessary updates to crosswalk and re-run the function\n")
        return(invisible(dat))
    } else {
        cat("No valid input. Please enter Y/N or y/n.\n")
    }
}

print("test")
