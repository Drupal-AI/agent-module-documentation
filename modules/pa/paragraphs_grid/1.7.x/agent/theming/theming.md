# Paragraphs Grid theming

## Theme hooks (`hook_theme`)
- `pg_button` — variables `label`, `icon`, `attributes`. Used by the grid widget UI buttons.
- `pg_bpoint_col_header` — variables `name`, `size`, `attributes`, `icon_attributes`. Renders
  a breakpoint column header in the widget.
Templates live under the module's `templates/`.

## Grid-class injection (module preprocess)
`paragraphs_grid.module` computes and applies the grid classes:
- `hook_preprocess_field()` — reads the grid field values and adds the resolved column/
  offset/order classes (from the active `grid_entity` `cell-properties` formatters) to the
  field/paragraph wrapper attributes.
- `hook_theme_suggestions_alter()` / `hook_theme_registry_alter()` — add grid-aware template
  suggestions so wrappers can carry `row`/`container` markup.
- `hook_entity_view_mode_alter()` — can switch the view mode used when rendering entities in
  the grid.
- `hook_page_attachments()` — attaches the active grid system's CSS library
  (`paragraphs_grid.bootstrap3/4/5` or `.mdc`) when `uselibrary` is enabled (and on admin
  pages when `use_lib_admin_pages` is set).

## Asset libraries (`paragraphs_grid.libraries.yml`)
- `paragraphs_grid.grid_widget` — editor widget JS/CSS (depends on `core/drupal`, `core/jquery`).
- `paragraphs_grid.bootstrap3` / `.bootstrap4` / `.bootstrap5` — the framework grid CSS.
- `paragraphs_grid.mdc` — Material Design Components grid CSS.

To use your theme's own grid CSS instead, set `uselibrary` to 0 on the settings form; the
module then only emits the classes and leaves the CSS to your theme.
