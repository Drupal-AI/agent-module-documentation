<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# BEF Entity Select Buttons (bef_entity_select_buttons) — agent index

A single **Better Exposed Filters (BEF) filter-widget plugin** that renders a Views exposed
filter's options as styled **buttons** (grid or flex), with an optional per-option **"add entity"**
link. Package `Views`. Version **1.0.0-alpha1**. Core `^9.4 || ^10 || ^11`. License GPL-2.0-or-later.

- **Depends on:** `better_exposed_filters` (hard dependency; the widget subclasses BEF's `Links`).
- **Adds no** routes, permissions, config schema, content entities, plugin *types*, or Drush.

- **The widget plugin, its settings, how to select it, the theme/preprocess, and the add-content
  service** → [plugins/entity-select-buttons.md](plugins/entity-select-buttons.md)

## What it actually is (from source)

- One plugin: `EntitySelectButtons` (id **`bef_entity_select_buttons`**, label *"BEF entity select
  buttons"*) in `src/Plugin/better_exposed_filters/filter/EntitySelectButtons.php`, **extending
  BEF's** `Drupal\better_exposed_filters\Plugin\better_exposed_filters\filter\Links`. It appears as
  a widget choice on a Views exposed filter's BEF settings (`@BetterExposedFiltersFilterWidget`).
- It changes only **presentation**: `exposedFormAlter()` sets `#theme = 'bef_entity_select_buttons'`,
  adds wrapper classes (`bef-entity-select-buttons`, `--full-width`, `--flex`/`--grid`), and passes
  `#button_small` and `#entity_type` flags. It reuses BEF's query/URL toggle logic unchanged.
- Theme hook `bef_entity_select_buttons` (`hook_theme` in the `.module`) whose template
  `templates/bef-entity-select-buttons.html.twig` just `{% include %}`s BEF's `bef-links.html.twig`
  with an extra class.
- Preprocess `bef_entity_select_buttons_preprocess_bef_entity_select_buttons()` calls
  `template_preprocess_bef_links()`, adds `button` / `button--small` / `button--primary` classes per
  option, wraps each option title in a `<span>`, and (when `#entity_type` is set) appends an
  add-content `Link` built by the service.
- One service: `bef_entity_select_buttons.content_paths` →
  `Service\ContentPathsService::getAddContentUrl($entityTypeId, $bundle)`, which resolves the
  bundle's `add-form` link template (or `node.add`) and returns the `Url` **only if
  `$url->access()` passes**.
- One asset library `bef_entity_select_buttons/general` (CSS + `js/bef-entity-select-buttons.js`;
  depends on `core/drupal`, `core/once`). The JS removes the add-button click handler on
  AJAX-enabled views so the add-link isn't misread as an option selection.

## Widget settings (`defaultConfiguration()`)

On top of BEF `Links` defaults: `display_full_width` (TRUE), `display_flex` (FALSE),
`small_buttons` (FALSE), `entity_add_button` (TRUE), plus declared-but-unused `button_size`,
`button_style`, `entity_type_icon`, `restrained_buttons`. Only `display_full_width`,
`display_flex`, `small_buttons`, `entity_add_button` have form controls in
`buildConfigurationForm()`. Details in
[plugins/entity-select-buttons.md](plugins/entity-select-buttons.md).
