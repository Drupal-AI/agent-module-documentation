<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Delta Formatter (entity_delta_formatter) — agent index

One field formatter that renders **only a chosen subset of an `entity_reference` field's referenced
entities, selected by delta**. Package `Fields`. No dependencies beyond Drupal core. Core requirement
`^8 || ^9 || ^10 || ^11`. License GPL-2.0-or-later. Version dir `8.x-2.x` (release 8.x-2.2).

- **The formatter — id, field type, the `deltas` setting, delta syntax, and the viewElements render path** →
  [fields/formatter.md](fields/formatter.md)

## What it actually is

- One plugin: `EntityReferenceDeltaFormatter` (id **`entity_reference_delta_formatter`**, label
  *"Rendered entities by delta"*) in
  `src/Plugin/Field/FieldFormatter/EntityReferenceDeltaFormatter.php`, **extending core's**
  `EntityReferenceEntityFormatter`. `field_types = { "entity_reference" }`.
- Adds one setting, `deltas` (default `''`), on top of the parent's rendered-entity settings. Config
  schema `field.formatter.settings.entity_reference_delta_formatter` extends
  `field.formatter.settings.entity_reference_entity_view` (`config/schema/`).
- No field type, no widget, **no permissions, no routes, no services, no Drush, no submodules**. Only
  `hook_help()` in `entity_delta_formatter.module`.

## Mechanism (from source)

- `viewElements()` clones the item list, calls `filterItemsByDelta()` to drop unselected deltas, then
  returns `parent::viewElements()` — so referenced entities are rendered by core's `entity_view()`
  pipeline (view mode, view-access checks, sanitization all inherited from core).
- `filterItemsByDelta()` parses the `deltas` string, normalizes it via `deltaNormalize()` (1-based →
  0-based, negatives from the end, clamped in range), builds a preserve-list of indices, and
  `removeItem()`s the rest. Details + delta syntax in [fields/formatter.md](fields/formatter.md).
