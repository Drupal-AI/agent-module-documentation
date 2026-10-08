<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Migrate Process Array provides Migrate process plugins for filtering, comparing and reshaping array values during migrations.

---

Migrate Process Array adds five Migrate **process plugins** that wrap common PHP array operations so a migration process pipeline can work with multi-value / array source data: `array_intersect` (keep only values that match a given list), `array_diff` (drop values found in a given list), `array_filter` (remove empty values or filter with a custom callable), `deepen` (wrap each item of a flat array in its own sub-array, optionally under a named key, ready for sub_process), and `extract_single` (core's `extract`, applied within each field-delta value instead of only the first). It is in the Migration package and requires no configuration UI.

Use it in the `process:` section of a migration YAML when a source field yields an array whose values must be intersected/differenced against a known set, filtered, or restructured before landing in a multi-value destination field. It is a developer/migration feature only — it transforms values during import under the migration's control and has no runtime, content, or access role. All plugins treat empty input and empty results as NULL (which Migrate skips).

---

- Keep only array values present in a known list (`array_intersect`).
- Whitelist multi-value source data against allowed terms.
- Remove array values found in an exclusion list (`array_diff`).
- Blacklist unwanted values from a multi-value field.
- Compare arrays by value, by associative pair, or by key.
- Use `assoc`, `key`, `uassoc` or `ukey` comparison methods.
- Supply a callable for user-defined key/assoc comparison.
- Strip empty values from an array (`array_filter`).
- Filter an array with a custom callback (`array_filter` + `callable`).
- Reference a static class method as the filter callable.
- Reshape a flat array into per-item sub-arrays (`deepen`).
- Assign a named key to each deepened item (e.g. `target_id`).
- Prepare merged values for the core `sub_process` plugin.
- Convert single field values into multi-value structures.
- Extract a nested value from every field delta (`extract_single`).
- Pull the same key out of each multi-value item, not just delta 0.
- Coerce a scalar source into a single-element array automatically.
- Chain array operations across multiple migration steps.
- Filter taxonomy/reference values before saving.
- Clean imported multi-value fields.
- Match array source values against a fixed vocabulary.
- Drop known-bad entries during import.
- Build multi-value entity reference fields from flat lists.
- Transform arrays without writing a custom process plugin.
- Handle array source data in Migrate pipelines.
- Serve legacy/content migrations that carry list data.
