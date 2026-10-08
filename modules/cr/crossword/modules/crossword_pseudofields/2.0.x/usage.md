<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Crossword Pseudofields breaks a crossword into individual "extra fields" — Title, Author, Notepad, Controls, Active Clue, Grid, Clues Across, Clues Down, and a "Make it Playable/Interactive" toggle — that you can place, order and hide separately on the entity display, instead of rendering the whole puzzle as one field.

---

This submodule of Crossword (requires `crossword` and core `node`) implements `hook_entity_extra_field_info()` and `hook_entity_view_alter()` so that, for any node bundle with a `crossword` field, nine pseudofields (`crossword_title`, `crossword_author`, `crossword_notepad`, `crossword_controls`, `crossword_active_clue`, `crossword_grid`, `crossword_across`, `crossword_down`, `crossword_playable`) appear on *Manage display*, each drawn from the shared `crossword_pseudofields` formatter render output. A global settings form at `/admin/config/content/crossword-pseudofields` (permission `configure crossword pseudofields`) stores the display options (buttons, redaction, clue/error/reference/rebus checkboxes, congrats message, detail tags) in config object `crossword_pseudofields.settings`, which every pseudofield rendering uses. When the sibling `crossword_media` module is enabled, the same pseudofields are also offered on media bundles. This lets you compose a puzzle page freely — e.g. title in a header region, grid in the main column, clue lists in a sidebar — and the "playable" pseudofield attaches the JS to make an otherwise static composition interactive.

---

- Place the crossword title, author and notepad independently on the entity display.
- Put the grid in one region and the across/down clue lists in another.
- Show the control bar (buttons, checkboxes) as its own placeable element.
- Add the active-clue banner separately from the grid.
- Hide any part of the puzzle by leaving that pseudofield disabled on Manage display.
- Reorder puzzle parts by dragging the pseudofields on Manage display.
- Make a hand-composed layout interactive with the "Make it Playable/Interactive" pseudofield.
- Configure buttons, redaction, checkboxes and messages once, globally, for all pseudofields.
- Set the congratulatory message and detail HTML tags for pseudofield rendering.
- Extend the same pseudofields to media bundles by also enabling crossword_media.
- Keep the pseudofield display options in exportable config (`crossword_pseudofields.settings`).
- Build a custom crossword page layout without a custom formatter or template override.
