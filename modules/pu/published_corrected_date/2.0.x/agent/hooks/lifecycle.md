<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Hooks and lifecycle

All behaviour lives in two procedural files — there are no services, classes, controllers or plugins.

## `hook_entity_base_field_info()` — defines the fields
`published_corrected_date.module:15-41`. Returns the three base fields (see
[../fields/base-fields.md](../fields/base-fields.md)) only when `$entity_type->id() == 'node'`.

## `hook_node_presave()` — populates the values
`published_corrected_date.module:46-66`. Runs on every node save. `$now = \Drupal::time()->getCurrentTime()`.

- **First publication:** if the node `isPublished()` **and** `published_date` is empty or `== 0`, set
  `published_date = $now`. This is the only branch that touches `published_date`, so it is written
  once and never overwritten while it holds a value.
- **Subsequent published save (a correction):** `elseif ($entity->isPublished())` — reads
  `correction_number->first()`. If that item exists, set `corrected_date = $now` and increment
  `correction_number` by 1 (`value + 1`). If it does not exist, initialise `correction_number` to 0.
- **Unpublished saves:** no branch matches, so nothing is written — dates stay untouched for drafts.

Consequences an agent should know:
- `changed` still moves on every save; these fields move only on *published* saves. A typo fix that
  keeps the node published counts as a correction and bumps `corrected_date` + `correction_number`.
- Because the increment happens on any published re-save, "number of corrections" counts published
  saves after the first, regardless of how substantive the edit was.
- Editing the two date values programmatically before the node is first published-saved is pointless:
  the first-publication branch overwrites `published_date` when it is empty/0.

## `hook_install()` — back-fills existing content
`published_corrected_date.install:13-19`. Runs four static `UPDATE` statements against
`{node_field_data}` using aggregates over `{node_field_revision}` (status = 1 rows only):
- `published_date` = `MIN(changed)` of published revisions (first publication).
- `correction_number` = `COUNT(0) - 1` of published revisions, then `0` where `NULL`.
- `corrected_date` = `MAX(changed)` of published revisions where `correction_number > 0`.

The SQL is static (no user input interpolated) — table/column names only.

## `hook_uninstall()` — clears the values
`published_corrected_date.install:24-27`. One `UPDATE {node_field_data} SET published_date = NULL,
corrected_date = NULL, correction_number = NULL;`.

## Not implemented
No `hook_help`, `hook_theme`, `hook_form_alter`, routing, permissions, config schema, services or
plugins. There is nothing else to hook into.
