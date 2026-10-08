Submodule of USWDS Paragraph Components that installs responsive two- and three-column layout paragraph types built on the USWDS grid (`grid-row` / `grid-col-*`).

---

Enabling this submodule (which requires `uswds_paragraph_components_breakpoints`) imports the `uswds_2_columns` and `uswds_3_columns` container bundles, their `uswds_2_column_breakpoints` / `uswds_3_column_breakpoints` helper bundles, and a `text_field` helper. Each container holds a per-column nested content field (`field_2_column_content` / `field_3_column_content`, which accept further paragraphs such as text, cards or alerts), a `field_column_grid_gap` toggle (→ `grid-gap`), and a breakpoints field (`field_uswds_2_column_breakpoints` / `field_uswds_3_column_breakpoints`). Each breakpoint helper row pairs a `field_uswds_breakpoints` term with a `field_*_column_grid_options` select whose value (`4-8`, `8-4`, `3-9`, `9-3`, `auto`, `even`, `100`) the template maps to complementary `grid-col-*` widths per breakpoint (the `mobile` term uses the prefix-less class). Templates emit `grid-container` > `grid-row` > per-column `grid-col-*` markup and attach the `uswds-grid-layout` CSS shim in non-preview view modes. Expose the two `uswds_*_columns` bundles on your field.

---

- Create a responsive two-column layout with configurable column split.
- Create a responsive three-column layout on the USWDS grid.
- Choose the column ratio per breakpoint (4-8, 8-4, 3-9, 9-3, auto, even, 100).
- Place different content (text, cards, alerts) into each column via nested Paragraphs.
- Add grid gaps between columns with the grid-gap toggle.
- Make a layout collapse to a single column on mobile by using the mobile breakpoint mapping.
- Build multi-region page sections without writing custom grid CSS.
- Default columns to an even 6/6 split when no breakpoint options are set.
- Combine columns with card groups to build complex landing pages.
- Nest a summary box or alert inside one column and body text in another.
- Vary the split at desktop vs tablet vs mobile using multiple breakpoint rows.
- Use `auto` width columns for content-sized columns.
- Span a full-width (100 → grid-col-12) column at a given breakpoint.
- Override `paragraph--uswds-2/3-columns.html.twig` to adjust the grid markup.
- Provide standardized, accessible USWDS grid layouts for a federal site.
