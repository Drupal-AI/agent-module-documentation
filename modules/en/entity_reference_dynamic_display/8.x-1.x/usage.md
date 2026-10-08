<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Reference Dynamic Display provides a "Dynamic Display" field formatter for entity reference (and entity reference revisions / paragraphs) fields. Instead of rendering every referenced entity in a single view mode, it lets a site builder pick a different view mode based on the referenced entity's bundle, or based on the item's delta (position) in the field.
This is handy for reference fields that mix bundles (e.g. a paragraphs field where the first item should render as a hero and the rest as teasers, or a related-content field where different content types use different display modes).
---
Install with `drush en entity_reference_dynamic_display` — there is no global configuration; the module only adds a formatter. On a reference field's Manage Display, choose the "Dynamic Display" formatter. In its settings, pick an override mode: "None" (behaves like the standard rendered-entity formatter), "Select view modes based on target bundle" (map each target bundle to a view mode), or "Select view modes based on item delta" (map delta positions to view modes) with a configurable default view mode.
The formatter extends core's `EntityReferenceEntityFormatter`, so it inherits core's referenced-entity access checking and recursion protection; it merely selects which view mode to hand to the entity view builder. It has no routes, permissions or endpoints.
---
- Install: `composer require drupal/entity_reference_dynamic_display && drush en entity_reference_dynamic_display -y`.
- On Manage Display, set a reference field's formatter to "Dynamic Display".
- Choose override mode "None" to mirror the default rendered-entity formatter.
- Choose "target bundle" mode to map each referenced bundle to its own view mode.
- Choose "delta" mode to map item positions to view modes.
- Set a default view mode used when no specific mapping applies.
- Render mixed-bundle paragraph fields with per-bundle displays.
- Show the first referenced item differently from the rest via delta mapping.
- Use different view modes for different related-content types in one field.
- Works with `entity_reference` and `entity_reference_revisions` field types.
- Inherits core referenced-entity access checks (no separate access surface).
- Combine with core view modes configured per target entity type.
- No global settings screen — configuration lives on each field's display.
- Recursion protection from the parent formatter still applies.
- Swap view modes without changing the field's storage or widget.
- Useful for Layout Builder and Paragraphs-heavy displays.
