<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Crossword field formatters

Three formatters ship in the base module; submodules add more (`crossword_image_rendered`,
`crossword_image_download`, `crossword_file_download_link`, `crossword_contest`). All target
`field_types = { "crossword" }`.

## `crossword` — "Crossword Puzzle" (playable)

`src/Plugin/Field/FieldFormatter/CrosswordFormatter.php`, extends core `FileFormatterBase`, injects
`crossword.data_service`. `viewElements()` calls `getEntitiesToView()` (honors core file access),
then `crosswordDataService->getData($file, $redacted)` and builds a `#theme => 'crossword'` render
array: title/author/notepad (as configurable html tags), across/down clue lists, the grid, the
control bar, and an `active_clues` region. It attaches library `crossword/crossword.default` (plus
`crossword.print` when enabled) and pushes the **parsed data to `drupalSettings.crossword.data`**,
where `js/classes.js` + `js/crossword.js` implement play. Cache tags come from the file.

`defaultSettings()` / schema key `field.formatter.settings.crossword`
(`base_crossword_field_formatter_settings`):

| Setting | Default | Meaning |
|---|---|---|
| `redacted` | `FALSE` | When TRUE, `CrosswordDataService::redact()` blanks every non-hint fill before it reaches the browser — the solution is never sent client-side. The settings form warns you to also hide the Solution/Cheat buttons and Show-Errors checkbox (they can't work while redacted). |
| `print` | `TRUE` | Attach `crossword.print` stylesheet. |
| `congrats` | `Well done!` | Plaintext message shown on correct completion. |
| `details.title_tag` / `author_tag` / `notepad_tag` | `h1` / `h2` / `p` | HTML tag for each; empty option = don't render that detail. |
| `buttons.class` | `NULL` | Extra CSS classes on all buttons (`Html::getClass()`-sanitized). |
| `buttons.buttons.{cheat,solution,clear,undo,redo,instructions}` | all `show: TRUE` | Per-button `show`, `input_label`, `confirm` (confirmation prompt text; empty = no confirm). Defaults: Clear/Solution get confirmation text. |
| `clues` | `do_not_render:FALSE, show:FALSE, checked:FALSE, input_label:'Show Clues'` | Optional "Show Clues" checkbox; `do_not_render` hides clue lists entirely (only the active-clue banner remains). |
| `errors` | `show:TRUE, checked:FALSE, input_label:'Show Errors'` | Optional "Show Errors" checkbox (highlights wrong entries — needs the solution, so useless when redacted). |
| `references` | `show:TRUE, checked:TRUE, input_label:'Show References'` | Optional "Show References" checkbox (highlights cross-referenced clues). |
| `rebus` | `show:FALSE, input_label:'Rebus entry active'` | Rebus checkbox; `show` forces it always visible, otherwise it appears only on rebus puzzles (`CrosswordDataService::isRebus()`). |

`settingsSummary()` reports only "Solution redacted" / "Solution is public". Embedded per-square
images (from `.xml` puzzles) are output as `data:image/…;base64,…` `<img>` tags
(`getEmbeddedImage()`).

## `crossword_solution` — "Crossword Solution" (static filled grid)

`CrosswordSolutionFormatter.php`, **extends `CrosswordFormatter`**, `BUTTONS = []`. Renders the grid
with fills shown (`getGrid($file, TRUE)`), title/author/notepad, and attaches only
`crossword/crossword.solution` (no play JS). Settings form drops `print`, `redacted`,
`redacted_warning`, `congrats`; only the `details` tag selectors remain (schema key
`field.formatter.settings.crossword_solution`). Use it to display the answer on a separate page/view
mode. Theme suggestion `crossword__crossword_solution` (and legacy `crossword_solution`) apply.

## `file_default_crossword` — "Generic file"

`CrosswordGenericFileFormatter.php` = `extends GenericFileFormatter {}`. The default formatter; just a
normal file download/link display so a crossword field degrades gracefully. Schema
`field.formatter.settings.file_default_crossword`.

## Choosing a formatter (config)

```bash
# Playable puzzle
drush cset core.entity_view_display.node.puzzle.default content.field_crossword.type crossword -y
# Static solution on a second view mode
drush cset core.entity_view_display.node.puzzle.solution content.field_crossword.type crossword_solution -y
drush cr
```

Tip: pair with the contrib **View Mode Page** module (or Views) to expose the playable and solution
displays on distinct routes for the same node.
