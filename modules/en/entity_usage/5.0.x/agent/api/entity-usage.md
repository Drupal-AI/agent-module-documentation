<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API — reading & writing usage data

The per-target usage report (`/admin/content/entity-usage/{entity_type}/{entity_id}`,
`ListUsageController`) lists every source that references the target:

![Entity Usage report page](../../../../../../../screenshots/entity_usage/5.0.x/usage-report.png)

Service `entity_usage.usage` — `Drupal\entity_usage\EntityUsage`, interface
`EntityUsageInterface`. Records are rows in the `entity_usage` table
(`entity_usage_schema()` in `entity_usage.install`): `target_id`/`target_id_string`,
`target_type`, `source_id`/`source_id_string`, `source_type`, `source_langcode`,
`source_vid`, `method` (usually the plugin id), `field_name`, `count`.

```php
$usage = \Drupal::service('entity_usage.usage'); // or inject EntityUsageInterface
```

## Read
- `listSources(EntityInterface $target, bool $nest_results = TRUE, int $limit = 0): array`
  — all sources that reference `$target`. Nested by default: `[source_type][source_id]
  => [ [source_langcode, source_vid, method, field_name, count], ... ]`. With
  `$nest_results = FALSE` returns a flat indexed list of full record arrays.
- `listTargets(EntityInterface $source, ?int $vid = NULL): array` — all targets a
  `$source` references, keyed `[target_type][target_id]`.
- `listTargetEntitiesByFieldAndMethod($source_id, $source_type, $source_langcode,
  $source_vid, $method, $field_name): string[]` — `"type|id"` strings for one
  source/field/method combination.
- Deprecated BC helpers `listUsage()` / `listReferencedEntities()` (removed in 3.0.0;
  use `listSources()` / `listTargets()`).

## Write / delete
- `registerUsage($target_id, $target_type, $source_id, $source_type, $source_langcode,
  $source_vid, $method, $field_name, $count = 1): void` — create/update a record
  (`$count >= 1`) or delete it (`$count <= 0`). **Honors the config settings** (may
  skip untracked combinations) and invokes `hook_entity_usage_block_tracking()`.
- `deleteBySourceEntity($source_id, $source_type, $source_langcode = NULL, $source_vid = NULL)`
- `deleteByTargetEntity($target_id, $target_type)`
- `deleteByField($source_type, $field_name)`
- `bulkDeleteSources($source_type)` / `bulkDeleteTargets($target_type)`

Each mutation dispatches an event (`Events\Events`): `USAGE_REGISTER`,
`DELETE_BY_SOURCE_ENTITY`, `DELETE_BY_TARGET_ENTITY`, `DELETE_BY_FIELD`,
`BULK_DELETE_SOURCES`, `BULK_DELETE_DESTINATIONS` (payload `Events\EntityUsageEvent`).

Normally you do **not** call the write methods yourself — `EntityUpdateManager`
(service `entity_usage.entity_update_manager`), invoked from the `#[Hook]` classes on
entity insert/update/delete, runs the active tracking plugins for you.

## Resolve a URL to an entity
Service `Drupal\entity_usage\UrlToEntity` (interface `UrlToEntityInterface`):
- `findEntityIdByUrl(string $url): ?array` — resolve an absolute or relative URL to
  `['type' => ..., 'id' => ...]` or `NULL`. Strips the site's own domain(s) via
  `SiteDomains`, then dispatches `Events::URL_TO_ENTITY` (`UrlToEntityEvent`); the
  first subscriber to identify an entity sets it and stops propagation. Bundled
  subscribers in `src/UrlToEntityIntegrations/`: `EntityRouting`, `LanguageIntegration`
  (always), plus `PublicFileIntegration` (if `file` enabled) and `RedirectIntegration`
  (if `redirect` enabled) — registered in `EntityUsageServiceProvider`.
- `findEntityIdByRoutedUrl(Url $url): ?array` — resolve an already-routed `Url`.

Add your own resolver by subscribing to `Events::URL_TO_ENTITY`.

## Views
`Hook\EntityUsageViewsHooks` exposes the `entity_usage` table (group "Entity Usage")
with a `count` field/sort/filter/argument, and adds a `{type}_to_usage_entity`
relationship on every fieldable entity base table so a View can join to its usage data.
