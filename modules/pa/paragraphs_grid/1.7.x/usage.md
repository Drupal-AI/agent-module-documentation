Paragraphs Grid lets editors arrange paragraph components into a responsive grid by adding a "Paragraphs grid" field that stores per-breakpoint column/offset/order classes (Bootstrap 3/4/5 or Material Design Components), rendered as grid wrapper markup around the paragraphs.

---

The module defines a `grid_entity` config entity that describes a **grid system** — its breakpoints (xs…xxl), column count, wrapper (container/row) options, and per-cell properties (columns, offset, order) with the CSS-class formatter for each — and ships four presets: `bs3`, `bs4`, `bs5`, and `mdc`. A global settings form (`/admin/config/content/paragraphs_grid`, route `paragraphs_grid.paragraphs_grid_config_form`, permission `use paragraphs_grid config form` which is `restrict access: TRUE`) picks the active `gridtype` and whether the module loads its own grid CSS library (`uselibrary`) and applies it on admin pages (`use_lib_admin_pages`). It provides a Field API triplet — field type `grid_field_type` ("Paragraphs grid"), widget `grid_widget` (an interactive per-breakpoint column picker), and formatters `grid_field_formatter` and `paragraphs_grid_formatter` (renders referenced entities inside grid markup) — plus theme hooks (`pg_button`, `pg_bpoint_col_header`), template/preprocess logic that injects the computed grid classes into field/paragraph markup, and `hook_page_attachments` to attach the chosen grid CSS. In practice you add a `grid_field_type` field to a paragraph type (or its host), let editors set columns per breakpoint with the widget, and the formatter emits `col-md-6`-style classes so paragraphs line up in a responsive grid without hand-writing layout.

---

- Lay out paragraph components in a responsive multi-column grid.
- Let editors choose how many columns a paragraph spans at each breakpoint (mobile→desktop).
- Build Bootstrap 5 (or 3/4) grid layouts from Paragraphs without custom code.
- Use Material Design Components (mdc) grid classes instead of Bootstrap.
- Set per-breakpoint column offsets to indent paragraphs.
- Reorder paragraphs visually per breakpoint with grid `order` classes.
- Switch the whole site's grid framework by changing the active grid type.
- Add container / container-fluid / row wrappers around a paragraph field.
- Render referenced paragraph entities inside grid markup via the grid formatter.
- Give content editors a visual column picker widget rather than raw class strings.
- Create magazine-style or card layouts using paragraphs as grid cells.
- Provide consistent responsive spacing across paragraph-built landing pages.
- Toggle whether the module's grid CSS library is loaded (use your theme's grid instead).
- Apply the grid CSS on admin/edit pages so the backend preview matches the front end.
- Define a custom grid system (breakpoints, columns, class formatters) as a `grid_entity`.
- Hide columns at specific breakpoints (e.g. `col-md-hide`).
- Make a paragraph full-width or auto-width at chosen breakpoints.
- Restrict grid-configuration changes to trusted admins (restricted permission).
- Combine grid classes with existing paragraph view modes and formatters.
- Prototype responsive page layouts quickly with reusable paragraph grids.
