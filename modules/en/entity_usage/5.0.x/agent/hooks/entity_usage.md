<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Hooks

## Hook the module invites: `hook_entity_usage_block_tracking()`
Declared in `entity_usage.api.php`. Lets a module veto a single tracking record
before it is written. Return `TRUE` to block; any other value lets it through.

```php
function mymodule_entity_usage_block_tracking(
  int|string $target_id, string $target_type,
  int|string $source_id, string $source_type,
  string $source_langcode, int $source_vid,
  string $method, string $field_name, int $count
): bool {
  // Don't track a specific field/method combination.
  return $field_name === 'field_foo_bar' && $method === 'link';
}
```
Invoked from `EntityUsage::registerUsage()`.

## Alter hook
- `hook_entity_usage_track_info_alter(array &$definitions)` — alter the discovered
  `EntityUsageTrack` plugin definitions (set via `EntityUsageTrackManager`).

## Hooks the module implements (5.0.x = OOP `#[Hook]` classes in `src/Hook/`)
No procedural hooks in a `.module` file. Implementations:
- `EntityUsageEntityHooks` — `entity_presave` (records the pre-save URL via
  `PreSaveUrlRecorder` for URL-change re-tracking), `entity_insert`, `entity_update`,
  `entity_predelete`, `entity_translation_delete`, `entity_revision_delete` (all drive
  `EntityUpdateManager`), and `entity_operation` (adds the "Usage" operation link for
  types in `local_task_enabled_entity_types`, gated by access).
- `EntityUsageFormHooks` — `form_alter`: shows the edit/delete-form warning messages
  (linking to the usage page) for configured types when the entity has recorded usages.
- `EntityUsageHooks` — `help`; `field_storage_config_delete` (purges usage for a
  deleted field via `deleteByField()`); `module_preuninstall` (drops track plugins and
  unsupported source types from config when a provider module is removed).
- `EntityUsageViewsHooks` — `views_data` / `views_data_alter` (see
  [api/entity-usage.md](../api/entity-usage.md)).
