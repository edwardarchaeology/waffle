load_fontawesome <- function() {
  # Register Font Awesome fonts with systemfonts
  fa_path <- system.file("fonts", package = "waffle")

  if (!nzchar(fa_path)) {
    warning("Font Awesome font directory not found in waffle package", call. = FALSE)
    return(invisible(FALSE))
  }

  # Register Font Awesome 5 Free Solid
  solid_path <- file.path(fa_path, "fa-solid-900.ttf")
  if (file.exists(solid_path)) {
    tryCatch(
      {
        systemfonts::register_font(
          name = "FontAwesome5Free-Solid",
          plain = solid_path
        )
      },
      error = function(e) {
        warning(
          "Could not register FontAwesome5Free-Solid font: ",
          conditionMessage(e),
          call. = FALSE
        )
      }
    )
  }

  # Register Font Awesome 5 Brands Regular
  brands_path <- file.path(fa_path, "fa-brands-400.ttf")
  if (file.exists(brands_path)) {
    tryCatch(
      {
        systemfonts::register_font(
          name = "FontAwesome5Brands-Regular",
          plain = brands_path
        )
      },
      error = function(e) {
        warning(
          "Could not register FontAwesome5Brands-Regular font: ",
          conditionMessage(e),
          call. = FALSE
        )
      }
    )
  }

  invisible(TRUE)
}
