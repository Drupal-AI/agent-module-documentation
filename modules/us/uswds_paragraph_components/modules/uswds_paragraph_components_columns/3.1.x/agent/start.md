# USWDS Columns — agent index

Submodule of [uswds_paragraph_components](../../../../3.1.x/agent/start.md). Requires
`uswds_paragraph_components_breakpoints`. Installs 2-/3-column USWDS grid layout paragraph types. No
settings page, no permissions. Hooks in `src/Hook/UswdsParagraphComponentsColumnsHooks.php`.

## Paragraph types & fields (config/optional)

Expose the two container bundles; the `*_breakpoints` and `text_field` bundles are children.

- **`uswds_2_columns`** / **`uswds_3_columns`** (containers):
  - `field_2_column_content` / `field_3_column_content` — nested Paragraphs (the column contents).
  - `field_column_grid_gap` (bool) → adds `grid-gap` to the `grid-row`.
  - `field_uswds_2_column_breakpoints` / `field_uswds_3_column_breakpoints` — nested breakpoint rows.
- **`uswds_2_column_breakpoints`** / **`uswds_3_column_breakpoints`** (child rows):
  `field_uswds_breakpoints` (term ref) + `field_2_column_grid_options` / `field_3_column_grid_options`
  (select).
- **`text_field`** — helper bundle with `field_text`.

## Rendering & assets

Theme hooks `paragraph__uswds_2_columns` / `paragraph__uswds_3_columns` →
`templates/paragraph--uswds-2/3-columns.html.twig`. Markup: `div.grid-container` > `div.grid-row[
.grid-gap]` > one `div.grid-col-*` per column. Each breakpoint row's `field_*_column_grid_options`
value maps to complementary widths, e.g. `4-8` → first col `grid-col-4` / second `grid-col-8` (with the
term prefix except for `mobile`); options: `4-8`, `8-4`, `3-9`, `9-3`, `auto`, `even` (6/6), `100`
(grid-col-12). Empty → default `grid-col-6`. CSS shim
`uswds_paragraph_components_columns/uswds-grid-layout` attached in `hook_preprocess_paragraph()` when
`view_mode !== 'preview'`.
