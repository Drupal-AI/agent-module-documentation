<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Display Layout (display_layout) — agent index

Lets you assign a **core Layout API layout** to an entity **view-display** (view mode) from the
*Manage display* form. Fields are sorted into the layout's regions and rendered inside the
layout's markup — no field groups, no Layout Builder required. Package `Display`. License
GPL-2.0-or-later. Version 1.0.2 (`1.0.x`). Core `^9 || ^10 || ^11`.

- **How selection, storage, and render alteration work; the form overrides; the Layout Builder
  interaction** → [config/layout-settings.md](config/layout-settings.md)

## Dependencies

- `drupal:layout_discovery` (the core Layout plugin type) and `drupal:field_ui` (the Manage
  display form it extends). No composer requirements, no libraries, no submodules.

## What it actually is (from source)

- **No routes, no permissions, no services.yml, no config schema, no Drush, no entities of its
  own.** It works entirely by overriding the edit form class of the core `entity_view_display`
  config entity and by altering entity view builds.
- `display_layout.module`:
  - `hook_entity_type_alter()` swaps the `entity_view_display` **`edit` form class**. If
    `layout_builder` is installed → `LBEntityViewDisplayLayoutEditForm`, else
    `EntityViewDisplayLayoutEditForm`.
  - `hook_entity_view_alter()` delegates to `DisplayLayoutEntityViewAlter::alter()` via the class
    resolver.
- `display_layout.install`: `hook_install()` calls `module_set_weight('display_layout', 1)` so its
  `hook_entity_type_alter()` runs **after** Layout Builder's.

## Key classes

- `src/DisplayLayoutFormTrait.php` — shared form building: `getLayoutForm()` (the "Display layout
  settings" details + a `display_layout_id` select), `getLayoutOptions()` (all core layout
  definitions grouped by category), `getLayoutRegions()` (regions of the chosen layout, plus a
  `hidden`/Disabled region), `getLayoutPluginManager()` (`plugin.manager.core.layout`).
- `src/Form/EntityViewDisplayLayoutEditForm.php` — extends core `EntityViewDisplayEditForm`; adds
  the selector, overrides `getRegions()`, saves the choice as third-party setting
  `display_layout.layout` on submit.
- `src/Form/LBEntityViewDisplayLayoutEditForm.php` — same, but extends
  `LayoutBuilderEntityViewDisplayForm`; only shows/saves the selector when Layout Builder is **not**
  enabled for that display (`isLayoutBuilderEnabled()`), otherwise defers entirely to Layout Builder.
- `src/DisplayLayoutEntityViewAlter.php` — at render time reads `display_layout.layout`, builds the
  layout, moves each component's render array into its `region`, and nests the result in
  `$build['content']`.

## Storage

- The selected layout id is a **third-party setting**: `third_party_settings.display_layout.layout`
  on the `entity_view_display` config entity — exported/imported with that config.
