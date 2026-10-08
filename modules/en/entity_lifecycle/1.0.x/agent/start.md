<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Lifecycle (entity_lifecycle) — agent index

Tracks content freshness. Adds lifecycle base fields to enabled content entity types, stamps a status
on every save, scans on cron against **`LifecycleCondition`** plugins, and surfaces stale content via an
editor banner and Views dashboards. Version **1.0.0-beta3** (version-dir `1.0.x`). Core `^10.3 || ^11`,
PHP `>=8.1`. License GPL-2.0-or-later. Depends on core **`node`** and **`views`**.

## What it provides

- **Config entity `lifecycle_status`** (`src/Entity/LifecycleStatus.php`): id, label, description, color,
  weight, `is_default`, `requires_review`. Install ships `current` (default), `needs_review`, `outdated`.
- **Five base fields** on enabled entity types (`entity_lifecycle_entity_base_field_info()`):
  `lifecycle_status`, `lifecycle_last_reviewed`, `lifecycle_exclude`, `lifecycle_override_days`,
  `lifecycle_condition_details`.
- **Plugin type `LifecycleCondition`** (manager `plugin.manager.lifecycle_condition`, namespace
  `Plugin/LifecycleCondition`, annotation `@LifecycleCondition`). Built-ins: `age`, `published_status`,
  `default_status`.
- **Config object** `entity_lifecycle.settings` (schema in `config/schema/entity_lifecycle.schema.yml`).
- **Permissions** (`entity_lifecycle.permissions.yml`): `administer entity lifecycle`,
  `view entity lifecycle dashboard`, `edit entity lifecycle status`, `override entity lifecycle`.
- **Routes** (`entity_lifecycle.routing.yml`): `entity_lifecycle.settings` (configure route),
  `entity_lifecycle.scan_bundle`, `entity_lifecycle.rebuild_bundle` — all `administer entity lifecycle`.
- **Drush** (`src/Drush/Commands/EntityLifecycleCommands.php`): `entity-lifecycle:scan|rebuild|stats|config`.
- **Views** integration: `lifecycle_status_filter` filter, `lifecycle_summary` area, review dashboards
  (`config/optional/views.view.entity_lifecycle_review.yml`, `views.view.media_lifecycle_review.yml`).
- **ECA events** and **submodules** (see below).

## Solution docs

- **Statuses, settings, routes, permissions, base fields, Views dashboards** →
  [config/settings.md](config/settings.md)
- **The scan pipeline: cron, presave stamping, scanner/evaluator/writer, Drush, banner** →
  [services/scanning.md](services/scanning.md)
- **The `LifecycleCondition` plugin type, condition groups, and built-in/extension plugins** →
  [plugins/conditions.md](plugins/conditions.md)
- **The five bundled submodules (ECA, User, Entity Usage, Link Checker, Radioactivity)** →
  [submodules.md](submodules.md)

## Dependencies & extension points

- Hard deps: `node`, `views`. Suggested: `eca`, `entity_usage`, `linkchecker`, `radioactivity`
  (each unlocks a submodule).
- Hooks in `entity_lifecycle.api.php`: `hook_entity_lifecycle_bundleless_entity_types`,
  `_bundleless_query_alter`, `_scan_result_alter`, `_stats_query_alter`, `_condition_excluded_entity_types`,
  `_summary_entity_types_alter`, `_summary_query_alter`, `_summary_render_alter`, `_summary_base_tables_alter`.
