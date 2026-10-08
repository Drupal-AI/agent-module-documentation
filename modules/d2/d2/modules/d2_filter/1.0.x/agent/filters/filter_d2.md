<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `filter_d2` text filter

`Drupal\d2_filter\Plugin\Filter\FilterD2` (`src/Plugin/Filter/FilterD2.php`) — the only thing this submodule
ships.

## Plugin definition (annotation)
- `id = "filter_d2"`
- `title = "D2 Filter"`, `description = "Render D2 diagrams."`
- `type = FilterInterface::TYPE_TRANSFORM_IRREVERSIBLE` — output cannot be reversed to source; keep it after
  markup-restricting filters.
- `weight = -10` — runs early relative to default filters.

## Processing
`process($text, $langcode)`:
- Runs `preg_replace_callback('@\[d2\](.+?)\[/d2\]@s', ...)` over the input. The `s` flag lets a diagram span
  multiple lines; `.+?` is non-greedy so multiple `[d2]` blocks in one text are matched independently.
- Each match's captured inner text is handed to `processD2($text)`, which calls
  `(new \Drupal\d2\D2Helper())->getSvg($text)` and returns the SVG string; that string replaces the whole
  `[d2]...[/d2]` block.
- Returns `new FilterProcessResult($text)`. No cache metadata/tags are attached by the filter itself; render
  caching happens inside `D2Helper::getSvg()` (keyed on a hash of the block source).

## Editor help
`tips($long = FALSE)` delegates to the static `help($long)`:
- Short: "Use D2 to generate an inline diagram."
- Long: an example `[d2] direction: right  Alice -> Bob [/d2]` plus links to d2lang.com and the project page.

## Setup
1. Enable: `drush en d2_filter` (requires `d2`, and the `d2` binary on the server — see the parent's
   `../../../../1.0.x/agent/api/rendering.md`).
2. Add "D2 Filter" to a text format at Configuration > Content authoring > Text formats and editors, then order
   the filters as needed.
3. Grant the text format to the roles that should author diagrams (standard `use text format …` permissions).

## Error behaviour
Failures from the CLI are handled entirely by `D2Helper::getSvg()`: errors are logged to the `d2` channel;
users with the parent module's `view d2 diagram errors` permission see the CLI error and the raw block source,
others get an empty replacement. The filter has no error handling of its own.
