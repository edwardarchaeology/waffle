#' @keywords internal
.has_font <- function(family) {
    # Returns TRUE if systemfonts can resolve a font family path
    tryCatch(
        {
            mf <- systemfonts::match_fonts(family)
            !is.null(mf$path) && nzchar(mf$path)
        },
        error = function(e) FALSE
    )
}
