<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Browser Multi Widget (entity_browser_multi) — agent index

A single **field widget** that places **multiple native Entity Browser launchers** on one
`entity_reference` field, all writing into the **same hidden selection target**. Package
*Entity Browser*. Depends on core **`field`** and **`entity_browser`** (`^2`). Core
`^11.4`, PHP `>=8.3`. License GPL-2.0-or-later. Version-dir 1.0.x (release 1.0.0-beta2).

- **The widget, its settings form, the drag-drop launcher table, config schema, and how
  multi-launcher rendering works** → [fields/widget.md](fields/widget.md)

## What it actually is

- One plugin: `EntityBrowserMultiWidget` (id **`entity_browser_multi`**, label
  *"Entity browser (multi)"*), in
  `src/Plugin/Field/FieldWidget/EntityBrowserMultiWidget.php`, **extending** Entity Browser's
  `EntityReferenceBrowserWidget`. `field_types = { "entity_reference" }`,
  `multiple_values = TRUE`. Declared with the `#[FieldWidget]` attribute; not `final` so it
  can be subclassed.
- **No routes, no controllers, no services, no permissions, no hooks, no Drush, no new entity
  type or admin page.** All selection, AJAX, and access handling is inherited from the stock
  `entity_browser` widget. Configuration lives only on a field's *Manage form display* widget
  settings.
- Provides **config schema** (`config/schema/entity_browser_multi.schema.yml`,
  `field.widget.settings.entity_browser_multi`) and two CSS libraries
  (`entity_browser_multi/widget`, `entity_browser_multi/widget.gin`).

## Mechanism (from source)

- `settingsForm()` hides the stock single `entity_browser` select and renders a sortable
  `#type => table` (`entity_browsers_drag_drop`) of every `entity_browser` config entity with
  an *enabled* checkbox and a *weight*. `validateEntityBrowsersDragDrop()` sorts by weight and
  derives `entity_browser` (first enabled) + `additional_entity_browsers` (the rest).
- `formElement()` calls `getOrderedEntityBrowsers()`; for each ordered browser it clones the
  parent's rendered `entity_browser` launcher element (setting `#entity_browser`) into an
  actions container so multiple launcher buttons appear, all bound to the same target.
- `afterBuildAddBarButtons()` styles the first launcher's `open_modal` button as primary.

## Config keys (widget settings)

`entity_browsers_drag_drop` (the table: `enabled`/`weight` per browser id), derived
`entity_browser` (primary) and `additional_entity_browsers` (sequence), legacy
`create_entity_browser`, plus inherited stock keys (`field_widget_display`,
`field_widget_edit`, `field_widget_remove`, `field_widget_replace`, `open`,
`field_widget_display_settings`, `selection_mode`). Full list in
[fields/widget.md](fields/widget.md).
