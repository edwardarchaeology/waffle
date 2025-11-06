# Waffles mappings from css names to unicode chars was out of date
# This variation updates it from the latests css from github
.fa_unicode_init <- function() {
  xdf <- readRDS(system.file("extdat/fadf.rds", package = "waffle"))
  xdf[xdf[["type"]] != "regular", ]
}

.fa_unicode <- .fa_unicode_init()

.display_fa <- function(fdf) {
  vb <- stringr::str_match(fdf[["glyph"]], '(viewBox="[^"]+")')[, 2]
  stringr::str_replace(
    fdf[["glyph"]],
    vb,
    sprintf('%s width="24" height="24"', vb)
  ) -> fdf[["glyph"]]
  DT::datatable(fdf[, c("name", "type", "glyph")], escape = FALSE)
}

#' Search Font Awesome glyph names for a pattern
#'
#' @param pattern pattern to search for in the names of Font Awesome fonts
#' @export
fa_grep <- function(pattern) {
  res <- which(grepl(pattern, .fa_unicode[["name"]]))
  if (length(res)) {
    .display_fa(.fa_unicode[res, ])
  } else {
    message("No Font Awesome font found with that name pattern.")
  }
}

#' List all Font Awesome glyphs
#'
#' @export
fa_list <- function() {
  .display_fa(.fa_unicode)
}

#' Install Font Awesome 5 Fonts
#'
#' @description
#' Font Awesome 5 fonts are bundled with the waffle package and will be
#' automatically registered with R using the systemfonts package when you use
#' glyphs in waffle charts.
#'
#' However, on some systems (especially Windows), graphics devices may not
#' recognize programmatically registered fonts. For best results, you should
#' install the fonts system-wide by:
#'
#' 1. Navigate to the font directory shown by this function
#' 2. Right-click each .ttf file and select "Install" or "Install for all users"
#' 3. Restart R/RStudio after installation
#'
#' If you need to use these fonts outside of waffle charts, the TTF font files
#' are located in the package installation directory.
#' @export
install_fa_fonts <- function() {
  fa_path <- system.file("fonts", package = "waffle")

  message(
    "Font Awesome 5 fonts are automatically registered with R via systemfonts.\n\n",
    "However, for full compatibility with all graphics devices (especially on Windows),\n",
    "you should install the fonts system-wide.\n\n",
    "Font files location:\n  ", fa_path, "\n\n",
    "Installation steps:\n",
    "  1. Open the folder above in File Explorer\n",
    "  2. Right-click each .ttf file\n",
    "  3. Select 'Install' or 'Install for all users'\n",
    "  4. Restart R/RStudio\n\n",
    "After system installation, Font Awesome glyphs should work on all graphics devices."
  )

  invisible(fa_path)
}

#' Font Awesome 5 Solid
#'
#' @description `fa5_solid` is shorthand for "`FontAwesome5Free-Solid`"
#' @docType data
#' @export
fa5_solid <- "FontAwesome5Free-Solid"

#' Font Awesome 5 Brand
#'
#' @description `fa5_brand` is shorthand for "`FontAwesome5Brands-Regular`"
#' @docType data
#' @export
fa5_brand <- "FontAwesome5Brands-Regular"
