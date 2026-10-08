# tablefield_cellspan — agent start

Submodule of **tablefield**. Adds cell-merging to rendered TableField tables by turning
`#colspan#`, `#rowspan#`, and `#remove#` markers typed into cell values into real HTML
`colspan`/`rowspan` attributes. Pure display-time transform via `hook_preprocess_table()`
that runs only on front-end (non-admin) routes. No UI, no settings, no permissions, no
config — enabling the module is the whole setup. Depends on `tablefield:tablefield`.

- Markers (`#colspan#`/`#rowspan#`/`#remove#`), how they merge, and the preprocess behavior → [theming/tablefield_cellspan.md](theming/tablefield_cellspan.md)
