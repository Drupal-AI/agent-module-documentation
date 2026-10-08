<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring a Double Reference field

## Add the field
When adding a field, pick **Double Reference** from the "Reference" category. It behaves like an Entity Reference field for the primary value and adds a second ("added") reference.

## Storage settings
- **Type of item to reference** (primary): the standard entity-reference `target_type`.
- **Added reference: Type of item to reference** (`ar_target_type`): the entity type for the second reference. Defaults to `node` (or `user` if node is absent). Locked once data exists. The DB column is `int unsigned` when the added target uses an integer ID, otherwise `varchar`.

## Field settings
- **Primary reference: Field label** (`pr_label`).
- **Added reference** group:
  - `ar_bundles` — allowed bundles for the added reference (required).
  - `ar_label` — label shown for the added reference.
  - `ar_weight` — negative to render the added reference first, positive to render it second.
  - `ar_required` — make the added reference required.

## Widgets & formatter
- Widgets: `double_reference_autocomplete` (default) and `double_reference_autocomplete_select`, both extending the core autocomplete widgets so the added reference gets its own autocomplete/select control.
- Formatter `double_reference_label` renders both labels; setting `ar_link` toggles whether the added reference's label links to its entity.

## Views & Entity Usage
- Views: the `*_target_id` and `*_ar_target_id` filters are switched to the `entity_reference` filter (or `taxonomy_index_tid` for taxonomy targets).
- Entity Usage: a Track plugin records usage for both the primary and added references.
