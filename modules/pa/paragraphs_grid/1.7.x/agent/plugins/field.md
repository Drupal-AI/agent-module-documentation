# Paragraphs Grid Field API plugins

The module provides one field type, one widget, and two formatters. These are Field API
plugins you *use* (attach to bundles), not a plugin type you extend.

## Field type — `grid_field_type`
- Label "Paragraphs grid" (`src/Plugin/Field/FieldType/GridFieldType.php`).
- Stores the per-breakpoint grid selection (columns/offset/order) so grid classes can be
  computed for the parent entity/paragraph.
- Add it to the paragraph type (or the host entity) via *Manage fields*.

## Widget — `grid_widget`
- Label "Grid widget" (`…/FieldWidget/GridWidget.php`), for `grid_field_type` fields.
- Renders an interactive per-breakpoint column picker (uses library
  `paragraphs_grid/paragraphs_grid.grid_widget` — `js/grid_widget.js`, `css/grid_widget.css`,
  `css/mdcfab.css`; theme hooks `pg_button`, `pg_bpoint_col_header`).
- Set it on the field in *Manage form display*.

## Formatters
- **`grid_field_formatter`** ("Grid field formatter", `…/FieldFormatter/GridFieldFormatter.php`)
  — outputs the grid classes for the grid field itself.
- **`paragraphs_grid_formatter`** ("Paragraphs Grid (rendered entity)",
  `…/FieldFormatter/ParagraphsGridFormatter.php`) — for the entity-reference-revisions field
  that holds the paragraphs; renders each referenced entity via `entity_view()` wrapped in the
  grid row/column markup. Set it on the paragraph reference field in *Manage display*.

## How classes reach the markup
`paragraphs_grid.module` (`hook_preprocess_field`, `hook_theme_suggestions_alter`,
`hook_theme_registry_alter`, `hook_entity_view_mode_alter`) reads the stored grid values,
resolves them against the active `grid_entity`'s `cell-properties` formatters
(`col%bp-%cols`, `offset%bp-%cols`, `order%bp-%cols`), and injects the resulting classes
(e.g. `col-md-6 offset-md-1`) onto the field/paragraph wrappers. See theming/theming.md.
