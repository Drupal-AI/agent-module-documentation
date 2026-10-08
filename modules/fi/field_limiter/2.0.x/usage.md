Field Limiter is a wrapping field formatter that renders only a slice (an offset plus a limit) of a multi-value field's items, delegating the actual rendering of the kept items to any other formatter for that field type.

---

The module provides a single formatter plugin, `field_limiter` ("Limit the number of rendered items"), built on the `field_formatter` module's `FieldWrapperBase`. On an entity's *Manage display* tab you pick it as the field's format, choose the real formatter to wrap (any formatter valid for that field type), and set two integers: **Skip items** (`offset`, default 0 — how many leading values to drop) and **Display items** (`limit`, default 0 — how many to show, where 0 means "all remaining"). It only renders when the field's cardinality is greater than 1; for single-value fields the settings form returns empty and no limiting applies. Although the plugin annotation lists only `entity_reference`, `hook_field_formatter_info_alter()` rewrites its `field_types` to **every** field type on the site, so it is available on text, number, link, media, and any other multi-value field. Internally `viewElements()` uses `array_slice($values, $offset, $limit)`, re-runs the wrapped formatter over the reduced item list, and returns only those child elements; when a limit is set it iterates to backfill the exact count if the wrapped formatter drops items. Settings persist in the `entity_view_display` component under schema `field.formatter.settings.field_limiter`, which nests the wrapped formatter's own `type` and `settings`. Requires the contrib `field_formatter` module.

---

- Show only the first N values of a multi-value field (e.g. the first 3 tags) while it stores many.
- Display just the first referenced entity from an entity-reference field.
- Skip the first value and render the rest (offset) — e.g. hide a "primary" item shown elsewhere.
- Render a windowed slice of values (skip 2, show 3) for a "more below" pattern.
- Limit rendered images in a multi-value image field without changing storage.
- Cap the number of rendered links in a multi-value link field.
- Wrap any core or contrib formatter and just trim how many items it outputs.
- Build a "featured first item" region by showing item 1 with one display and the rest with another.
- Trim long taxonomy term lists in teasers while keeping the full list on the detail view.
- Show a preview count of related content references in a compact view mode.
- Limit paragraphs or media rendered in a summary/card display.
- Provide different item counts per view mode (e.g. 1 in teaser, all in full) using the same field.
- Reduce page weight by rendering fewer items of a heavy multi-value field.
- Apply an offset to paginate-like split a field's values across two display regions.
- Keep the wrapped formatter's own settings intact while only changing the item count.
- Use on any field type (not just entity reference) thanks to the info-alter that opts in all types.
- Show "top 5" style truncated lists from an ordered multi-value field.
- Display only the newest/first author in a multi-author reference field.
