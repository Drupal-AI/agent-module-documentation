<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Key Value Field Feeds Extension bridges the Feeds module and the Key Value Field module by supplying Feeds *target* plugins for the `key_value` and `key_value_long` field types.

---

Out of the box, Feeds cannot map incoming data into key/value fields. This module adds two `@FeedsTarget` plugins — `KeyValue` (for `key_value`, plain text) and `KeyValueLong` (for `key_value_long`) — under `src/Feeds/Target/`. Each declares the field's sub-properties (`key`, `value`, and `description`) to the Feeds UI so you can map source columns to them. The `key` column is marked unique (`markPropertyUnique`) so it can be used as a de-duplication / unique target during import. `prepareValue()` trims the `key`, skips a delta entirely when the key is blank (semantically empty), and casts `value` and `description` to strings.

It depends on both `feeds` and `key_value_field`. There are no routes, permissions, services, or config — it is purely a set of mapping plugins consumed inside a Feeds importer. No external calls or security-sensitive surface; input sanitisation is limited to trimming/string-casting the mapped sub-values.

---
- Map an imported column to the `key` of a key_value field.
- Map a column to the `value` of a key_value field.
- Populate a key_value field's `description` from a feed.
- Import into a `key_value_long` field for longer values.
- Use `key` as a unique target to de-duplicate imported rows.
- Update existing entities keyed on the key_value `key`.
- Skip rows whose key is blank automatically.
- Build a CSV importer that fills a key/value field.
- Import RSS/XML data into structured key/value pairs.
- Migrate legacy key/value data via a Feeds importer.
- Sync key/value attributes from an external system on a schedule.
- Map multiple key/value deltas from a repeating source element.
- Normalise imported values to strings automatically.
- Combine with other Feeds targets in one importer mapping.
- Trim stray whitespace from imported keys.
- Provide editors a no-code way to import into key/value fields.
- Keep key/value taxonomies of attributes up to date from a feed.
