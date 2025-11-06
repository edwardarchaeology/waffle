# Migration from extrafont to systemfonts - Summary

## Overview

This document summarizes the changes made to migrate the waffle package from the archived `extrafont` package to the actively maintained `systemfonts` package.

## Files Modified

### R Source Files

1. **R/waffle-package.R**

   - Removed: `@importFrom extrafont ttf_import font_import choose_font`
   - Added: `@importFrom systemfonts match_fonts register_font`

2. **R/font-helpers.R**

   - Updated `.has_font()` function to use `systemfonts::match_fonts()` instead of `match_font()` (deprecated)

3. **R/zzz.R**

   - Completely rewrote `load_fontawesome()` function
   - Now uses `systemfonts::register_font()` instead of `extrafont::font_import()`
   - Added better error handling and warnings
   - Registers Font Awesome fonts programmatically from package's inst/fonts directory

4. **R/waffle.R**

   - Updated documentation to remove references to `extrafont`
   - Replaced `extrafont::choose_font()` with `.has_font()` helper
   - Updated error messages to reference `install_fa_fonts()` instead of extrafont
   - Removed `library(extrafont)` from examples
   - Added Windows-specific warning about font rendering on certain graphics devices
   - Fixed deprecated `size` parameter to `linewidth` in `geom_tile()` calls (ggplot2 3.4.0+)

5. **R/fontawesome.R**
   - Updated `install_fa_fonts()` documentation and message
   - Now explains that fonts are automatically registered via systemfonts
   - Provides clear instructions for system-wide font installation on Windows
   - Returns the font path invisibly for programmatic use

### Package Metadata

6. **NAMESPACE**

   - Removed: `importFrom(extrafont,choose_font)`, `importFrom(extrafont,font_import)`, `importFrom(extrafont,ttf_import)`
   - Added: `importFrom(systemfonts,match_fonts)`, `importFrom(systemfonts,register_font)`

7. **DESCRIPTION**
   - Already had `systemfonts` in Imports (no changes needed)
   - No longer requires `extrafont` (was not listed as dependency)

### Documentation Files

8. **man/install_fa_fonts.Rd**

   - Updated description with detailed installation instructions
   - Added Windows-specific guidance

9. **man/waffle.Rd**
   - Updated to remove `extrafont` references
   - Changed to mention `systemfonts` package
   - Updated examples to remove `library(extrafont)`

## Key Changes Summary

### Font Detection

- **Before**: `extrafont::choose_font(family, quiet = TRUE)`
- **After**: `.has_font(family)` using `systemfonts::match_fonts(family)`

### Font Registration

- **Before**: `extrafont::font_import(paths = ..., recursive = FALSE, prompt = FALSE)`
- **After**: `systemfonts::register_font(name = ..., plain = ...)`

### ggplot2 Compatibility

- **Before**: `geom_tile(..., size = size)`
- **After**: `geom_tile(..., linewidth = size)` (ggplot2 3.4.0+ compatibility)

## Benefits

1. **No dependency on archived package**: `extrafont` is no longer maintained on CRAN
2. **Modern approach**: `systemfonts` is actively maintained and recommended
3. **Simpler implementation**: Direct font registration without import step
4. **Better error handling**: Clearer messages and warnings
5. **Cross-platform**: Works consistently across operating systems
6. **Future-proof**: Compatible with latest ggplot2 versions

## Known Limitations

### Windows Graphics Devices

On Windows, some graphics devices (especially the default device and PostScript/PDF) may not recognize programmatically registered fonts. For full compatibility:

1. Users should install Font Awesome fonts system-wide
2. Run `install_fa_fonts()` for instructions and font location
3. Right-click .ttf files and select "Install for all users"
4. Restart R/RStudio

This limitation is inherent to how Windows handles fonts in graphics devices, not a limitation of systemfonts.

## Testing

All basic waffle chart functionality works without any font installation.
Font Awesome glyph functionality requires system-wide font installation on Windows for optimal rendering.

## Backward Compatibility

This change should be fully backward compatible for package users:

- All existing code using basic waffle charts continues to work
- Font Awesome glyph usage requires font installation (same as before, but now via systemfonts)
- No changes to user-facing API
