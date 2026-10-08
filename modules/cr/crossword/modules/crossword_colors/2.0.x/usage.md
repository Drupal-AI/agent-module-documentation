<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Crossword Colors adds an admin form where you pick the highlight and text colors used when a crossword is played (active square, active clue, referenced clues, error text) and writes them into a generated CSS file that is appended to the crossword stylesheet — no theme editing required.

---

This submodule of Crossword (requires `crossword`) provides `CrosswordColorsConfigForm` at `/admin/config/crossword/colors` (permission `configure crossword colors`) with five HTML color pickers stored in config object `crossword_colors.settings`: `active_highlight`, `active_square`, `reference_highlight`, `reference_text`, `error_text` (defaults in `config/install/`). On save, `CrosswordColorsService::saveCrosswordColorsCss()` validates each value with `Color::validateHex()` and writes matching CSS rules to `public://crossword-colors.css`; `crossword_colors_library_info_alter()` appends that file to the base `crossword.default` library so the colors apply everywhere the playable formatter renders. The submit handler also clears the library-discovery cache and CSS aggregation so the new colors show immediately.

---

- Change the background color of the active (focused) square.
- Change the highlight color for squares in the active clue and the active clue in the list.
- Change the highlight color for cross-referenced clues.
- Change the text color used for referenced clue text in the active-clue header.
- Change the text color used for errant squares/clues when "Show Errors" is on.
- Restyle crossword colors through the admin UI without editing theme CSS.
- Keep the color choices in exportable configuration (`crossword_colors.settings`).
- Have color changes apply site-wide to every playable crossword automatically.
- See color changes immediately (the form clears the relevant caches on save).
- Restrict color configuration to trusted roles via `configure crossword colors`.
