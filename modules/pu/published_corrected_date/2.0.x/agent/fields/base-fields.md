<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Base fields on `node`

The module adds **three base fields to every node bundle** via
`published_corrected_date_entity_base_field_info()` (`published_corrected_date.module:15`), guarded by
`if ($entity_type->id() == 'node')`. They are populated automatically (see
[../hooks/lifecycle.md](../hooks/lifecycle.md)); there is no widget and no form-display entry, so they
are **not editable in the node edit form** — the README states they "cannot be modified in the UI".

| Machine name | Field type | Label | Description | Default | Revisionable | Translatable |
|---|---|---|---|---|---|---|
| `published_date` | `timestamp` | Published on | The time that the node was published. | `NULL` | no | yes |
| `corrected_date` | `timestamp` | Corrected on | The time that the node was corrected. | `NULL` | no | yes |
| `correction_number` | `integer` | Number of corrections | The number of corrections published. | `0` | no | yes |

Definitions (`published_corrected_date.module:19-38`) call only
`setLabel` / `setDescription` / `setDefaultValue` / `setRevisionable(FALSE)` / `setTranslatable(TRUE)`.
Notably absent: `setDisplayOptions()` and `setDisplayConfigurable()` are **not** called, so these do
not appear in the default node view/form displays and are not rendered by the theme by default.

## How to read / display the values

- **In code / Twig:** the stored value is a Unix timestamp (or integer for the count).
  `$node->get('published_date')->value`, `$node->get('corrected_date')->value`,
  `$node->get('correction_number')->value`. In a node template:
  `{{ node.published_date.value }}` (raw timestamp — format it with the `format_date` filter).
- **Views:** because they are base fields on the `node_field_data` table, they are available as
  node fields in the Views UI (add "Content: Published on", "Content: Corrected on",
  "Content: Number of corrections"), usable as fields, sorts and filters — e.g. sort a news listing
  by `published_date` descending.
- **Layout Builder:** exposed as field blocks that can be placed on a node layout.
- The two date fields are `timestamp` fields, so a date/time formatter applies when rendered; the
  count is a plain integer.

## Gotchas

- `published_date` and `corrected_date` are `NULL` until the node is first saved **published**
  (see the presave logic). Unpublished nodes never get a value.
- These fields are **not revisionable**, so they hold only the current value, not per-revision
  history — even though `corrected_date`/`correction_number` are derived from revision activity at
  install time.
- Removing the module nulls all three columns (`hook_uninstall`); it does not delete the columns
  until the base-field definitions are torn down by Drupal's field storage cleanup.
