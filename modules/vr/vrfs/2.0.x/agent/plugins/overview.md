<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views Reference Field Suite — plugins

All functionality is delivered as Field/ViewsReference plugins; configure through Field UI (Manage form display / Manage display).

## Field formatters (Manage display)
- `ViewsReferenceFieldFormatterImproved` — renders the referenced view; reads per-reference settings from the serialized `data` column via `unserialize($item->getValue()['data'], ['allowed_classes' => FALSE])`.
- `ViewsReferenceLazyFieldFormatterImproved` — lazy-builder variant; unserializes `data` and `enabled_settings` with `allowed_classes => FALSE` before building.

## Field widget (Manage form display)
- `ViewsReferenceSelectWidgetImproved` — Autocomplete Deluxe-based selector for choosing the view/display; also decodes existing `data` safely.

## ViewsReferenceSetting plugins (per-field config)
- `ViewsReferenceFilters` — expose/override view filters (serializes the selection into the stored settings).
- `ViewsReferenceExposedFilters` — let editors set exposed filter values per reference.
- `ViewsReferenceArgumentTokenizer` — tokenize/override the view's contextual arguments.

## Setup
1. Add a Views Reference field to an entity (requires `viewsreference`).
2. On the form display, select `ViewsReferenceSelectWidgetImproved`.
3. On the view display, select an improved formatter and enable the ViewsReference settings editors may override.
4. Gate suite configuration with the `administer vrfs configuration` permission.
