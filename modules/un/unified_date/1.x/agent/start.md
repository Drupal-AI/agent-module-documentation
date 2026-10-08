<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Unified Date (unified_date) — agent index

Adds a single `timestamp` base field `unified_date` to **every node** and, on each node presave,
syncs a **per-bundle chosen date source** into it — so multiple content types with different date
fields can be sorted/filtered together on one column. Package `Soapbox`. Depends on core **`node`**
and **`datetime`**. Core `^9 || ^10 || ^11`. License GPL-2.0-or-later. Version 1.0.6 (dir `1.x`).

- **Configuration, the field mapping, batch + Drush backfill** → [config/settings.md](config/settings.md)
- **The `unified_date` base field, presave sync, token, alter hook** → [fields/unified_date.md](fields/unified_date.md)
- **The `unified_datetime` Views filter plugin** → [plugins/views-filter.md](plugins/views-filter.md)

## What it actually is (from source)

- **One base field**, `unified_date` (type `timestamp`, revisionable, translatable), declared for the
  `node` entity in `EntityHook::entityBaseFieldInfo()` (`src/Hook/EntityHook.php`), wired via
  `unified_date_entity_base_field_info()`.
- **Presave sync**: `EntityHook::nodePresave()` sets `unified_date` to
  `UnifiedDateManager::getUnifiedDate($node)` on every node save (`hook_node_presave`).
- **Source resolution** (`UnifiedDateManager::getUnifiedDate`, `src/UnifiedDateManager.php`): reads
  config `unified_date.settings` key `node_types.<bundle>`; strips a `base-field:` prefix and an
  optional `:<value_location>` suffix (e.g. `field_range:end_value`); non-numeric values pass
  through `strtotime()`; empty → `NodeInterface::getCreatedTime()`. Then invokes
  `hook_unified_date_alter($date, $node)`.
- **Two config forms** (routes in `unified_date.routing.yml`, both `_permission: administer site
  configuration`): `SettingsForm` at `/admin/config/content/unified-date` (per-bundle select of the
  source field) and `BulkUpdateForm` at `.../bulk-update` (batch backfill).
- **Batch**: `UnifiedDateBatchProcessor` (`src/UnifiedDateBatchProcessor.php`) processes 5 nodes/step
  via `UnifiedDateManager::getNodeIdsForBatch()`.
- **Drush** (`src/Commands/UnifiedDateCommands.php`, `drush.services.yml`):
  `unified-date:write-all` (alias `udwa`) and `unified-date:write-missing` (`udwm`), optional
  comma-separated node-type argument.
- **Views**: `ViewsHook::viewsDataAlter()` sets the filter id of `node_field_data.unified_date` to
  `unified_datetime`; the plugin is `src/Plugin/views/filter/UnifiedDatetime.php` (extends core
  `Date`).
- **Token**: `unified_date.tokens.inc` adds `[node:unified_date]` (formats the timestamp `medium`)
  plus `date`-type sub-tokens.
- **Help**: `UnifiedDateHook::help()` for `help.page.unified_date`.
- No permissions of its own, **no submodules**, no libraries. Config schema in
  `config/schema/unified_date.{schema,filter.schema}.yml`.

## Provides

- Base field: `unified_date` (node, `timestamp`).
- Config object: `unified_date.settings` (`node_types` sequence: bundle → source field key).
- Routes: `unified_date.settings`, `unified_date.bulk_update`.
- Services: `unified_date.manager` (aliased `UnifiedDateManager`), `unified_date.batch_processor`,
  the three `Hook\*` classes, `unified_date.commands` (Drush).
- Views filter plugin `unified_datetime`; node token `unified_date`; alter hook
  `hook_unified_date_alter()`.

## Operate

1. Enable: `drush en unified_date`. The base field appears automatically; run
   `drush updatedb` for any pending updates.
2. Visit `/admin/config/content/unified-date`, pick a source field per content type (unset = created
   time), save.
3. Backfill existing nodes via the **Bulk update** tab or `drush unified-date:write-all`.
4. Use the field in Views for sorting/filtering, or as `[node:unified_date]`.
