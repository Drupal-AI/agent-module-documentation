# Views Block Placement Exposed Form Defaults — agent index

Lets you mark some of a Views **block** display's exposed filters as "customizable", then set
**default values** for them each time the block is placed (Block layout / Layout Builder). Works
by replacing the core Views Block display plugin. Requires `views` + `block`. No admin page,
permissions, config entity, or Drush of its own.

- **Mark filters customizable on the block display, set defaults on placement, where it's stored** →
  [configure/exposed-defaults.md](configure/exposed-defaults.md)

Key facts:
- `hook_views_plugins_display_alter()` swaps the core Views `Block` display class for
  `ExposedFormBlockDisplay`.
- Display option `customizable_exposed_filters` (a map of filter id → filter id) is stored on the
  view's block display: `views.view.<id>` → `display.<block_display>.display_options.customizable_exposed_filters`.
- Per-placement default values are stored as `exposed_filter_values` on the placed block's
  configuration (`views_block` schema); `preBlockBuild()` applies them via `setExposedInput()`.
- Schema for both keys is added by `hook_config_schema_info_alter()` (no `config/schema` dir).
