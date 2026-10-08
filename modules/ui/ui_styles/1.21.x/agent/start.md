<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# UI Styles — agent index

UI Styles discovers reusable **style plugins** (named sets of CSS classes) from any
`*.ui_styles.yml` file in an enabled module or theme, and exposes them as the
`ui_styles_styles` form element so builders can apply those classes to blocks, Layout
Builder, views, regions, CKEditor, etc. The base module ships **no admin UI** and
`configure` is `null`; the submodules provide the integration points.

- **Define a style plugin (YAML format, all keys, options map)** →
  [plugins/define-styles.md](plugins/define-styles.md)
- **Source plugin types (select/checkbox/toolbar) + the `selected`/`extra` storage shape** →
  [configure/source-and-selection.md](configure/source-and-selection.md)
- **Apply styles in code: `StylePluginManager`, `addClasses()`, the `ui_styles_styles`
  element, `hook_ui_styles_styles_alter`** →
  [api/apply-styles.md](api/apply-styles.md)
- **Stylesheet generator (`/ui_styles/stylesheet`), previews, CSS-variable extraction** →
  [theming/stylesheet-generator.md](theming/stylesheet-generator.md)

Key facts:
- Discovery service: `plugin.manager.ui_styles` (`Drupal\ui_styles\StylePluginManager`),
  YAML property `ui_styles` (files `<provider>.ui_styles.yml`). Cache tag `ui_styles`.
- A definition's `options` keys **are** the CSS classes; values are the option labels.
- Selection config schema type: `ui_styles.selected_mapping` = `{ selected: [class...], extra: "free classes" }`.
- Render element: `#type => 'ui_styles_styles'` (`Drupal\ui_styles\Element\Styles`).
- Submodules: block, ckeditor5, entity_status, layout_builder, library, page, ui_patterns, views.
