# Cell merging via markers (theming)

TableField Cellspan has **no configuration** (the README is explicit: no menu, no settings).
All behavior comes from `hook_preprocess_table()` — `tablefield_cellspan_preprocess_table()`
in `tablefield_cellspan.module`. Enable the module and use the markers.

## Where it runs

- Implements `hook_preprocess_table(&$variables)`, so it acts on **every** rendered `<table>`
  (not just TableField), rewriting `$variables['rows'][…]['cells']` before Twig renders.
- **Front-end only:** it returns early on admin routes — guarded by
  `\Drupal::service('router.admin_context')->isAdminRoute()`. So the merges appear on the
  public display, not while editing.
- It only touches cells whose `content` is a plain string; if a cell's `content` is an array
  or object it stops processing that row's remaining cells.
- The stored TableField value is **not** modified — this is purely a display-time transform.

## The three markers

Type these literal tokens as the text of a table cell (via the TableField widget grid, or any
default value). The cell containing the marker is normally consumed and its span is folded
into a neighbour.

| Marker | Effect |
|---|---|
| `#colspan#` | Deletes this cell and increases the `colspan` of the cell **immediately to its left**. Put it in a right-hand cell to make the left cell span both columns. Consecutive `#colspan#` cells keep widening the same left cell (colspan grows 2, 3, …). |
| `#rowspan#` | Deletes this cell and increases the `rowspan` of the nearest non-empty cell in the **same column of a previous row** (searches upward). Put it in the cell below to make the cell above span down. Repeat in each cell underneath to span more rows (rowspan grows 2, 3, …). |
| `#remove#` | Deletes this cell entirely — no `<td>` is emitted. Use it to clear the leftover cell(s) a span would otherwise leave on the row/edge. |

## Typical patterns

- **Horizontal merge:** left cell = your text, next cell = `#colspan#`. The left cell spans 2
  columns.
- **Span a whole row:** first cell = text, every following cell = `#colspan#`.
- **Vertical merge:** top cell = text, the cell directly below = `#rowspan#`. The top cell
  spans 2 rows. Add `#rowspan#` in the next row down to span 3, etc.
- **Tidy leftovers:** if a merge leaves an unwanted trailing cell, put `#remove#` in it.

## Notes / gotchas

- Because the guard is `isAdminRoute()`, tables shown on admin-theme pages are left unmerged.
- Merging depends on cell ordering/keys in the preprocessed `rows` array; markers reference the
  *previous* cell (colspan) or the *nearest filled cell above in the same column* (rowspan).
- There are no permissions, config schema, plugins, or Drush commands in this submodule.
