# Layout Options — agent index

Provides a `LayoutOptions` layout plugin + `LayoutOption` option plugins so you add styling
controls (CSS classes, id, custom classes) to Drupal layouts via YAML — mostly no PHP. Depends
on `layout_discovery`. The base module has **no settings form** (`configure: null`).

- **The `[provider].layout_options.yml` file format (definitions + rules)** →
  [configure/yaml-options.md](configure/yaml-options.md)
- **`LayoutOption` plugin type, the built-in option plugins, implementing one** →
  [plugins/layout-options.md](plugins/layout-options.md)

Key facts:
- Layout plugin class: `Drupal\layout_options\Plugin\Layout\LayoutOptions` (extends core
  `LayoutDefault`). A layout must use this class for its options to appear. The
  **`layout_options_ui`** submodule swaps existing layouts to this class via config.
- Options are declared in `[module_or_theme].layout_options.yml` with two sections:
  `layout_option_definitions` and `layout_options` (rules: `global` / `<layout_id>` / field).
- `LayoutOption` plugin type: annotation `@LayoutOption`, manager
  `plugin.manager.layout_options` (`plugin.manager.layout_options`). Built-in ids:
  `layout_options_id`, `layout_options_class_select`, `layout_options_class_radios`,
  `layout_options_class_checkboxes`, `layout_options_class_string`.
- No permissions, no Drush; config schema only stores option values
  (`layout_options.single_valued_option`, `layout_options.multi_valued_option`).
