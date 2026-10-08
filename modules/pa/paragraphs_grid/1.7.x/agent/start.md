# Paragraphs Grid — agent index

Responsive grid layout for Paragraphs: a `grid_field_type` field stores per-breakpoint
column/offset/order classes (Bootstrap 3/4/5 or MDC), and formatters emit the grid markup.
Depends on `paragraphs`. Provides a config entity, a restricted config permission, and a
Field API type/widget/formatter set.

- **Global settings form + the `grid_entity` presets/config entity** → [configure/settings.md](configure/settings.md)
- **Field type `grid_field_type`, widget `grid_widget`, the two formatters** → [plugins/field.md](plugins/field.md)
- **Theme hooks and grid-class injection into markup** → [theming/theming.md](theming/theming.md)

Key facts:
- Config route `paragraphs_grid.paragraphs_grid_config_form` at
  `/admin/config/content/paragraphs_grid`, permission **`use paragraphs_grid config form`**
  (`restrict access: TRUE`). Settings: `gridtype`, `uselibrary`, `use_lib_admin_pages`.
- `grid_entity` config entity (`@ConfigEntityType`, admin_permission `administer site
  configuration`) — presets `bs3`, `bs4`, `bs5`, `mdc` in `config/install/`. Fields:
  `breakpoints`, `wrapper`, `cell-properties` (col/offset/order), `library`.
- Field plugins: type `grid_field_type`, widget `grid_widget`, formatters
  `grid_field_formatter` and `paragraphs_grid_formatter` (renders referenced entities in grid).
- CSS libraries `paragraphs_grid.bootstrap3/4/5`, `.mdc`, `.grid_widget`; attached via
  `hook_page_attachments` when `uselibrary` is on.
