<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Migrate Process Array adds five array-manipulation process plugins to Drupal's Migrate framework for filtering and reshaping list values during a migration.

---

When a migration source value is an array, you often need to keep only the members that match a known set, drop the ones you want to exclude, filter with your own callback, or restructure a flat list into per-delta sub-arrays. This module supplies process plugins for exactly those jobs: **`array_intersect`** (keep the source values that appear in a `match` list) and **`array_diff`** (keep the values *not* in an `exclude` list), both supporting the PHP `assoc`/`key`/`uassoc`/`ukey` comparison variants via a `method` key; **`array_filter`** (PHP `array_filter`, with an optional custom `callable` exactly like core's `callback` plugin); **`deepen`** (wrap each flat value in its own single-element array — the opposite of flatten — with an optional `key` to make each an associative pair, ideal before `sub_process`); and **`extract_single`** (core's `extract`, but applied within each field value/delta so you can pull the same nested key out of every item). You add each by its `plugin:` id inside a migration's `process:` pipeline and run it under Drush; there is no settings form and no request-time surface. It supports Drupal 9.3, 10, and 11, and core Migrate must be enabled for the plugins to run.

---

- Keep only the array members that match a known set (`array_intersect`).
- Drop the array members that appear in an exclude set (`array_diff`).
- Filter an array with a custom callback (`array_filter`).
- Remove falsy/empty members from an array (`array_filter` with no callable).
- Compare arrays by key rather than value (`method: key`).
- Compare arrays by key and value together (`method: assoc`).
- Use a user callback for key/associative comparison (`method: uassoc` / `ukey`).
- Match a source array against a fixed whitelist of allowed values.
- Exclude a blacklist of unwanted values from a source array.
- Reshape a flat list into per-delta sub-arrays for a multi-value field (`deepen`).
- Key each deepened value (e.g. `target_id`) before an entity-reference `sub_process`.
- Pull the same nested key out of every field delta (`extract_single`).
- Provide a default when an extracted index is missing (`extract_single` `default`).
- Normalise a scalar source into a single-element array automatically.
- Reduce a multi-value field to a filtered subset during import.
- Clean up merged/concatenated array fields mid-pipeline.
- Chain array operations across several process steps.
- Author the migration in YAML and run it under Drush.
- Migrate taxonomy/term or reference sets against known values.
- Prepare source data for `sub_process` or entity-reference destinations.
- Transform array data without writing a bespoke process plugin.
- Enable alongside core Migrate; keep disabled when not migrating.
- Confirm plugin behaviour on your own source data before a production run.
