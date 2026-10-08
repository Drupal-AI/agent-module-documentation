<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Reference Overflow (entity_reference_overflow) — agent index

A single field formatter that renders an `entity_reference` field's manually-selected entities and, when
that count is below a configured **Minimum Items**, appends dynamically queried related published entities
until the threshold is met. Package `Field types`. **No** module dependencies (core only), no Composer/PHP
library requirements, no permissions, no services, no routes, no hooks, no settings page. Core requirement
`^8.8.0 || ^9.0 || ^10 || ^11`. License GPL-2.0-or-later. Version 1.0.0.

- **The formatter, its settings, the overflow query, and how entities are rendered** →
  [fields/formatter.md](fields/formatter.md)

## What it actually is

- One plugin: `EntityReferenceOverflowFormatter` (id **`entity_reference_overflow`**, label *"Reference
  Overflow"*), in `src/Plugin/Field/FieldFormatter/EntityReferenceOverflowFormatter.php`, extending core's
  `EntityReferenceEntityFormatter` (the "Rendered entity" formatter). `field_types = { "entity_reference" }`.
- It changes only how an entity-reference field is **displayed**. Selected per view-display on *Manage
  display* → *Format* = "Reference Overflow". Configure with the gear icon.
- Config schema `field.formatter.settings.entity_reference_overflow` in
  `config/schema/entity_reference_overflow.schema.yml`. No `config/install`.

## Mechanism (from source)

- `viewElements()` calls `parent::viewElements()` to render the manually-referenced entities, then computes
  `calcItemsNeeded() = min_items - $items->count()`. If `<= 0`, returns the parent output unchanged.
- Otherwise it builds `relatedItemQuery()`: an entity query on the field's `target_type`, filtered to the
  field's `target_bundles`, `status = 1`, sorted by `sort_field` DESC, ranged to the shortfall, excluding
  the already-referenced ids and (if same type) the host entity, and optionally constrained to share values
  in the configured `ref_fields`. Results are `loadMultiple()`ed and rendered via the entity view builder in
  the configured `view_mode`, then `array_merge`d after the manual output.

## Settings (`defaultSettings()`)

`min_items` (3), `ref_fields` (`[]`), `sort_field` (`created`), plus everything inherited from
`EntityReferenceEntityFormatter` (notably `view_mode`, `link`). Details in
[fields/formatter.md](fields/formatter.md).
