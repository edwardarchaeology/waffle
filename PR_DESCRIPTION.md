# Replace extrafont with systemfonts

## Summary

This PR migrates the waffle package from the archived `extrafont` package to the actively maintained `systemfonts` package, resolving dependency on unmaintained software and fixing compatibility issues with modern ggplot2.

## Motivation

- `extrafont` has been archived on CRAN and is no longer maintained
- Using an archived package poses long-term maintenance and compatibility risks
- `systemfonts` is actively maintained and is the recommended modern approach for font handling in R

## Changes Made

### Core Font Handling

- **Replaced `extrafont` with `systemfonts`** for all font detection and registration
- Updated `load_fontawesome()` to use `systemfonts::register_font()` instead of `extrafont::font_import()`
- Replaced `extrafont::choose_font()` with `.has_font()` helper using `systemfonts::match_fonts()`

### Bug Fixes

- **Fixed ggplot2 3.4.0+ deprecation**: Changed `size` to `linewidth` in `geom_tile()` calls
- **Fixed systemfonts 1.1.0+ deprecation**: Changed `match_font()` to `match_fonts()`

### Documentation Updates

- Removed all references to `extrafont` from documentation and examples
- Updated `install_fa_fonts()` with clear instructions for Windows users
- Added helpful warnings about font rendering on Windows graphics devices
- Updated all `.Rd` documentation files

### Improved User Experience

- Better error messages that guide users to solutions
- Clearer font installation instructions, especially for Windows
- Added platform-specific guidance for graphics device compatibility

## Files Modified

- `DESCRIPTION`: Updated dependency from extrafont to systemfonts (version bumped to 1.0.3)
- `NAMESPACE`: Updated imports
- `R/waffle-package.R`: Updated imports
- `R/font-helpers.R`: Created with `.has_font()` helper using systemfonts
- `R/zzz.R`: Rewrote `load_fontawesome()` for systemfonts
- `R/waffle.R`: Updated font checking, fixed deprecations, improved docs
- `R/fontawesome.R`: Enhanced `install_fa_fonts()` with detailed instructions
- `man/install_fa_fonts.Rd`: Updated documentation
- `man/waffle.Rd`: Updated documentation
- `.gitignore`: Added test files

## Testing

- ✅ All basic waffle chart functionality works without changes
- ✅ Font Awesome glyph rendering works (with system-wide font installation on Windows)
- ✅ No breaking changes to user-facing API
- ✅ Backward compatible with existing code

## Known Limitations

On Windows, graphics devices require system-wide font installation for Font Awesome glyphs (same as before, but now with clearer instructions). This is a Windows graphics device limitation, not a systemfonts issue.

## Benefits

1. No dependency on archived/unmaintained package
2. Modern, actively maintained font handling
3. Better error messages and user guidance
4. Compatible with latest ggplot2 versions
5. Simpler implementation with fewer dependencies
6. Future-proof maintenance

## Backward Compatibility

This change is fully backward compatible:

- All existing user code continues to work without modification
- Font Awesome glyph usage works the same way (with clearer setup instructions)
- No changes to function signatures or user-facing API

---

**Additional Notes:**

- A detailed migration summary is included in `MIGRATION_NOTES.md`
- This resolves potential CRAN submission issues related to archived dependencies
