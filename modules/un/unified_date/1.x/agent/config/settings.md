<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration, field mapping & backfill (unified_date)

## Install / enable

`drush en unified_date` (deps: core `node`, `datetime`). The `unified_date` base field is added to
node automatically; run `drush updatedb` to apply update hooks. `unified_date_update_10001()`
(`unified_date.install`) migrates a pre-`node_types` config layout by moving raw config data under a
`node_types` key. `unified_date_post_update_convert_views_filters()` rewrites existing Views filters
that used the old `unified_datetime` plugin id back to core `date` bound to `entity_field:
unified_date` (a legacy migration; new filters still resolve to `unified_datetime`, see
plugins/views-filter.md).

## Config object: `unified_date.settings`

Schema: `config/schema/unified_date.schema.yml`.

```
unified_date.settings:
  node_types:            # sequence, bundle machine name => source field key (string)
    <bundle>: <field-key>
```

`<field-key>` forms understood by `UnifiedDateManager::getUnifiedDate()`:

- `base-field:created` | `base-field:changed` | `base-field:published_at` — a core node base field
  (the `base-field:` prefix is stripped before reading).
- `<field_name>` — a configured datetime/timestamp field's `value`.
- `<field_name>:end_value` — the end of a `daterange` / `daterange_timezone` / `smartdate` field.

If a bundle has no entry, the value defaults to the node's created time. Default source when nothing
is configured is `base-field:created`.

## Settings form — `/admin/config/content/unified-date`

`Drupal\unified_date\Form\SettingsForm` (route `unified_date.settings`, permission
**`administer site configuration`**; menu under Configuration → Content). One **required** `select`
per node type; options come from `UnifiedDateManager::getNodeDateFields($bundle)`, which offers:

- configured fields of type `datetime` / `timestamp` → `<field>`;
- configured `daterange` / `daterange_timezone` / `smartdate` fields → both `<field>` and
  `<field>:end_value`;
- base fields `created`, `changed`, `published_at` → `base-field:<name>`.

Submitting writes `node_types.<bundle>` for every bundle.

## Bulk backfill

The source is only recomputed when a node is **saved**, so change the mapping then backfill.

- **Batch form** — `/admin/config/content/unified-date/bulk-update` (`BulkUpdateForm`, route
  `unified_date.bulk_update`, same permission). Check the node types, submit; `UnifiedDateBatchProcessor::processBatch()`
  runs 5 nodes per step and reports a count via `finishedBatch()`.
- **Drush** (`UnifiedDateCommands`, requires Drush 12+):
  - `drush unified-date:write-all [types]` (alias `udwa`) — recompute for all matching nodes.
  - `drush unified-date:write-missing [types]` (alias `udwm`) — only nodes whose `unified_date`
    is `0`/NULL. `[types]` is an optional comma-separated bundle list, e.g. `udwa article,page`.

Both drive `UnifiedDateManager::writeAll()` / `writeMissing()` → `processNodes()`, which queries node
ids (entity query with `accessCheck(FALSE)` — an admin/CLI maintenance operation), loads them in
chunks of 50, and calls `setNodeUnifiedDate()` (which sets the field and `$node->save()`).
