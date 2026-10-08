<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Crossword adds a **`crossword` field type** whose uploaded puzzle files (Across Lite text/`.puz`, Crossword Compiler `.xml`, `.ipuz`) are parsed server-side into a common data structure and rendered as a fully keyboard-navigable, browser-**playable** crossword (or as a static solution, an image, or a download link).

---

Crossword is a display/authoring toolkit for puzzles that were created elsewhere — it does not author puzzles itself. It defines a `crossword` field type (`CrosswordItem`, extending core `FileItem`) that accepts `txt puz xml ipuz` uploads, plus a `crossword_file_parser` plugin type with four bundled parsers (`across_lite_text`, `across_lite_puz`, `crossword_compiler_xml`, `ipuz`) that each turn a file into a normalized array of grid squares and across/down clues. The central `crossword.data_service` (`CrosswordDataService`) runs the applicable parser, caches the result in the dedicated `crossword` cache bin keyed by file id, adds keyboard-movement and clue cross-reference data, normalizes text encoding to UTF-8, and runs every displayed string through `Xss::filter`, then invokes the `hook_crossword_data_alter` alter hook. Two validation constraints (`CrosswordFile`, `CrosswordDimensions`) reject unparseable files and out-of-range grids at upload time. The main **Crossword Puzzle** formatter (`crossword`) emits a themed grid, clue lists and control buttons and passes the parsed data to `drupalSettings` where `js/crossword.js` + `js/classes.js` drive play (arrow-key movement, rebus entry, cheat/solution/clear/undo/redo, error highlighting, clue references, a congratulations message). Companion formatters give a static **Crossword Solution** (`crossword_solution`) and a plain **Generic file** (`file_default_crossword`). A **Crossword Instructions** block documents the keyboard shortcuts. Eight submodules extend it: `crossword_image` (GD image generation + a `crossword_image` plugin type), `crossword_media` (a `crossword` media source with generated thumbnails), `crossword_token` (file tokens for author/title/dimensions/image), `crossword_download` (download-link formatters), `crossword_pseudofields` (expose title/author/grid/clues as node & media pseudofields), `crossword_status` (client-side solved/in-progress classes), `crossword_colors` (UI to set highlight/text colors), and `crossword_contest` (a low-stakes contest with server-side answer checking). Rendering is heavily templatable (a dozen `crossword_*` theme hooks with per-formatter and per-direction suggestions) and the author has pledged screen-reader accessibility.

---

- Publish a browser-playable crossword by uploading an Across Lite `.txt` or `.puz` file to a `crossword` field.
- Accept Crossword Compiler `.xml` or `.ipuz` puzzles as well as Across Lite formats.
- Add a Crossword field to a node type (say a "Puzzle" content type) and set its display to the **Crossword Puzzle** formatter.
- Let solvers move with arrow keys, jump between clues, and enter rebus (multi-character) squares.
- Offer Cheat, Solution, Clear, Undo, Redo and Instructions buttons, each optionally requiring a confirmation prompt.
- Show a congratulatory message when a puzzle is solved correctly.
- Redact the solution so the answers are never sent to the browser (for puzzles you don't want spoiled or scraped).
- Highlight solving errors and cross-referenced clues on demand via checkboxes.
- Render a filled-in **Crossword Solution** view of the same puzzle on a different page or view mode.
- Enforce minimum/maximum grid rows and columns per field so editors can't upload oversized puzzles.
- Reject corrupted or unsupported files at upload with a clear validation message.
- Restrict which parsers a given field accepts (e.g. only allow `.ipuz`).
- Generate a thumbnail or solution image of a puzzle for teasers using the `crossword_image` submodule.
- Integrate puzzles with core Media, using a generated crossword image as the media thumbnail.
- Provide `[file:crossword_title]`, `[file:crossword_author]`, `[file:crossword_dimensions]` and image tokens for use in other fields and formatters.
- Offer download links to the original puzzle file or to a generated solution image.
- Break a puzzle into individually placeable pseudofields (title, author, notepad, grid, clues, controls) on node and media displays.
- Add a "Make it Playable/Interactive" pseudofield to turn an otherwise static rendering into a live puzzle.
- Add `solved` / `in-progress` CSS classes to crossword teasers client-side (localStorage-based) for a "puzzles you've finished" listing.
- Customize the active-square, active-clue, reference and error colors through an admin form without writing CSS.
- Run a low-stakes solve-to-unlock contest where a correct submission reveals special content (coupon, message) validated server-side.
- Add a Crossword Instructions block documenting the keyboard shortcuts on any puzzle page.
- Theme any part of the puzzle (grid, square, clue, controls) via the `crossword_*` Twig templates and per-formatter suggestions.
- Alter the parsed puzzle data (titles, clues, movement logic) programmatically with `hook_crossword_data_alter`.
- Add support for a new puzzle file format by writing a `crossword_file_parser` plugin.
