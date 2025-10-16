#' Cleaning the major_code, major_description, college and level
#' @description
#' This functions cleans the major_code, major_descriptions college and level with the help of crosswalk table
#' which contains up to date records of change in major and its respective alliances.
#'
#' @param crosswalk a data-frame containing raw major_codes, major_descriptions, college and level. The function also give
#' some suggestion if the file2clean contains new record of majorcode which is not already present in the crosswalk. In such case
#' please update the crosswalk file and execute the function again. The first four columns of the data-frame should contain
#' the raw records while the next four updated or the corrections.
#'
#' @param file2clean a data-frame or the file to be cleaned. For instance, application_admission, enrollment, degree_awarded, etc.
#'
#' @param fieldnames a vector of column names in the file to be cleaned. Supply the columns containing major_code, major_description, college
#' and  the level in the file supplied to the above file2clean argument. The output file will contain the same columns
#' in same order of the supplied file with cleaned columns supplied as filed names. Please input the vector of fieldnames in the order of
#' and exactly like \code{c("major_code","major_description","college","level")}
#'
#' @param ug a category specially in level field, representing undergraduates 'UG'. By default it
#' is False because most of the project and analysis are performed for graduate students. If Ture it
#' the UG level is not filtered out and may produced various updates suggestion because the crosswalk
#' does not contain updates regarding UG students.
#'
#' @param collegename an option to choose the longer or shorter version of the collage
#' names. By default it is set to \code{"long"}. If needed the \code{"short"} can be supplied to the
#' collegename argument in order to get short version of the college name. For example,
#' Collage of Liberal Arts is the full name while Liberal Arts is the shorter name.
#'
#' @author
#' Chitra Karki \email{cbkarki@miners.utep.edu}
#' Data Science Program, Mathematical Sciences,
#' University of Texas at El Paso,
#' Graduate School
#'
#' @return If discrepancies are found, a data frame of unmatched records is returned
#' and optionally saved to file. Otherwise, a message is printed.
#'
#' @importFrom dplyr mutate recode filter %>% arrange distinct anti_join select
#'
#' @importFrom readxl read_excel
#' @importFrom openxlsx write.xlsx
#' @importFrom tcltk tk_choose.dir

#'
#' @examples
#'
#' \dontrun{
#' major_clean(crosswalk_df, student_df, c("Major", "MajorCode", "College", "Level"))
#' }
#'major_clean <- function(crosswalk, file2clean, fieldnames, ug = FALSE) {
 #'   # function code here
#'}
#'
#' @export
#'
#'
# current_students <-
#      read_xlsx("C:/Users/chitr/OneDrive - University of Texas at El Paso/Core Data/Source Data/Data Updates/Current Students Apr. 28, 2025.xlsx")
#
# degrees_awarded <- read_xlsx("C:/Users/chitr/OneDrive - University of Texas at El Paso/Core Data/Source Data/Degrees Awarded.xlsx")
#  # cross walk for cleaning majors
#  major_list <- read_xlsx("C:/Users/chitr/OneDrive - University of Texas at El Paso/Core Data/Source Data/Crosswalk Table.xlsx",
#                         sheet = "Consolidated Major List Update")
#
# lapply(c("tidyverse","readxl","openxlsx"),library,character.only = TRUE)
#
# fieldnames <- c("Major","MajorCode","College","Level")


major_clean <- function(crosswalk, file2clean,fieldnames, ug = FALSE, collegename = "long") {

    major_list <- crosswalk
    dat <- file2clean
    fieldnames = fieldnames

    if(!ug) {
        dat <- dat %>%
        filter(toupper(trimws(dat[[fieldnames[4]]])) != "UG")}

    # standardizing collage names; recording to shorter names so that it can be mapped to the crosswalk
    # in degree_awarded, the colleges are coded with abbreviation
    dat <- dat %>%
        mutate(!!fieldnames[3] := recode(dat[[fieldnames[3]]],

                                     # decoding in degrees awarded
                                     `ED` = 'Education',
                                     `LA` = 'Liberal Arts',
                                     `SN` = 'Nursing',
                                     `SC` = 'Science',
                                     `EN` = 'Engineering',
                                     `BU` = 'Business Administration',
                                     `HS` = 'Health Sciences',
                                     `PH` = 'Pharmacy',
                                     `UC` = 'Liberal Arts',
                                     `0` = 'Liberal Arts',
                                     `EI`= 'Engineer.Sci/Interdisciplinary',

                                     # enrollment has college name in shorter version
                                     # stop-out has college name in shorter version

                                     # converting long names of colleges to short names in application and admission data
                                     `College of Education` = 'Education',
                                     `College of Liberal Arts` = 'Liberal Arts',
                                     `College of Nursing` = "Nursing",
                                     `College of Science` = 'Science',
                                     `College of Engineering` = "Engineering",
                                     `College of Business Admin.` = "Business Administration",
                                     `College of Health Sciences` = 'Health Sciences',
                                     `School of Pharmacy` = 'Pharmacy',
                                     `Policy & Economic Development` = 'Liberal Arts',
                                     `Office of Academic Affairs` = "Liberal Arts",
                                     `University College` = "Liberal Arts",
                                     `Woody L. Hunt College of Busin` = "Business Administration",

                                     # collage names from current students list
                                     `University College` = "Liberal Arts",
                                     `Policy & Economic Development` = 'Liberal Arts',
                                     `Graduate Studies` = 'Engineer.Sci/Interdisciplinary'

                                     # add other colleges names not present in this list

                                     )
               )



    #print(unique(dat$college_temp))
    #checking for any new records not present in cross walk

    #using dynamic names
    by_fields <- setNames(
        c("MajorDescription...1", "MajorCode...2", "College...3", "Level...4"),
        fieldnames
    )

    updates <- anti_join(dat %>%
                             #select(.data[[fieldnames[1]]],.data[[fieldnames[2]]],.data[[fieldnames[3]]],.data[[fieldnames[4]]]),
                         select(all_of(fieldnames)),
                         major_list,
                         by = by_fields
                         ) %>%
        distinct() %>%
        arrange(fieldnames[1])

    if(nrow(updates) == 0) {
        message("No new records found in: ", deparse(substitute(file2clean)))
        message("Continuing with cleaning............. \n")
        continue = readline(prompt = "Press [Enter] to Continue..")
        if (continue != "") stop()
        message("great you are here")

        # main cleaning block, where cleaned major_code, major_desc, college_names,
        # and levels are picked form crosswalk, Additionally ask user to stick with
        # longer version or shorter version of college name.

        # creating look-up table for crosswalk
        major_list_fact_table <-
            major_list %>%
            select(!c(Notes)) %>%
            mutate(College_short = coalesce(College...7,College...3),
                   Major_temp = coalesce(MajorDescription...5,MajorDescription...1),
                   MajorCode_temp = coalesce(MajorCode...6,MajorCode...2),
                   Level_temp = coalesce(Level...8,Level...4),
                   College_long = recode(College_short,
                                              "Business Administration" = "College of Business Admin.",
                                              "Education" = "College of Education",
                                              "Engineer.Sci/Interdisciplinary" = "Engineer.Sci/Interdisciplinary",
                                              "Engineering" = "College of Engineering",
                                              "Health Sciences" = "College of Health Sciences",
                                              "Liberal Arts" = "College of Liberal Arts",
                                              "Nursing" = "College of Nursing",
                                              "Office of Academic Affairs" = "College of Liberal Arts",
                                              "Pharmacy" = "School of Pharmacy",
                                              "Science" = "College of Science"
                                         )
                   ) %>%
            distinct(MajorDescription...1,
                     MajorCode...2,
                     College...3,
                     Level...4,
                     College_short,
                     College_long,
                     Major_temp,
                     MajorCode_temp,
                     Level_temp
                     )

        # pulling clean columns to the main dat file
        dat_clean <-
            left_join(dat,major_list_fact_table,
                      by = by_fields
                      )
        #%>%   select(!all_of(fieldnames[3]))


        # replacing the updates to the original field names in dat or the user file
        # long vs short names of the collegs

        collegename = match.arg(collegename)
        if (!collegename %in% c("long","short")) {
            stop('Invalid value for `collegename`. Please use either "long" (default) or "short".')

        } else if (collegename == "short") {

            rename_map <- setNames(c("Major_temp","MajorCode_temp","College_short","Level_temp" ),
                                   fieldnames)

        } else {

            rename_map <- setNames(c("Major_temp","MajorCode_temp","College_long","Level_temp" ),
                                   fieldnames)

        }

        # data clean names and ordering the coln names as of original file
        dat_clean <- dat_clean %>%
            select(!all_of(fieldnames)) %>%
            rename(!!!rename_map) %>% # works like key:dictinory
            select(names(dat))

        # writing output
        write_cleanfile_csv(dat_clean)


    } else {
        message(nrow(updates)," new records found in ", deparse(substitute(file2clean)), ".\n",
                "Please, make necessary updates to ", deparse(substitute(crosswalk)),
                " and execute the function again.\n"
                #,"\nRecommendation:\n",
                # "Write the output as .xlsx or .cvs, append to the crosswalk\n",
                # "do reviews, save it and re-execute the function.\n",
                # "Ex: updates <- major_clean(, , ,); write.csv(updates,\"C:/User/....updates.csv\")\n\n"
                )

        #ask user for input, if they want to write an csv output
        write_updates_csv(updates)

    }

}

# major_clean(major_list,degrees_awarded,fieldnames = fieldnames,ug = FALSE)


