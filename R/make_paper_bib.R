#' Make .bib files for papers
#'
#' This function will create .bib files in the Hugo Academic style for papers
#' specified in a Google Sheet.
#'
#' @param dir The directory you would like the markdown documents to be saved in
#' @param id Your Google Sheet id
#' @export
make_paper_bib <- function(dir, id = "1_6rm_Us8Q_d8V_xMI3yzCJZ0ENWNDJcYcMc7JVeJDtI") {
  d <- googlesheets4::range_read(googlesheets4::as_sheets_id(id))
  d <- d[d$type == "article", ]
  bib <- d$bib

  file_base <- purrr::map_chr(d$bib, ~ strsplit(.x, '[{,]')[[1]][2])
  file_name <- glue::glue("{dir}/{file_base}.bib")
  purrr::walk2(bib, file_name, writeLines)
}
