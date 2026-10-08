<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Count (entity_count) — agent index

Admin **report of how many entities are stored per type**, with an optional per-bundle breakdown, under
Administration > Reports. Version **8.x-1.x** (installed as the `1.x` dev branch — the only branch whose
`core_version_requirement` allows Drupal 11; tagged 1.0.0–1.3.0 are `^8 || ^9 || ^10` only). Core `^9 || ^10 || ^11`.
License GPL-2.0-or-later. No dependencies beyond core, no config, no submodules, no Drush.

- **The two report routes, the controller, permission, and how counts are computed** →
  [reports/entity-count.md](reports/entity-count.md)

## What it actually is

- One controller: `EntityCountController` (id-less service via `ControllerBase`), in
  `src/Controller/EntityCountController.php`, with two methods: `entityCount()` and `perBundle()`.
- One permission: **`access entity count`** (`entity_count.permissions.yml`) — gates both routes.
- One menu link: `entity_count` under `system.admin_reports` (`entity_count.links.menu.yml`).
- No config objects, no config schema, no plugins, no hooks, no blocks, no `.install`.

## Routes (`entity_count.routing.yml`)

- `entity_count` → `/admin/reports/entity-count` → `EntityCountController::entityCount` (per-type totals).
- `entity_count.per_bundle` → `/admin/reports/entity-count/{entity_type}` → `EntityCountController::perBundle`
  (per-bundle totals for one type). Both require `_permission: access entity count`.

## How counts are produced (from source)

- `entityCount()` iterates `entity_type.manager` `getDefinitions()`. Config entity types
  (`ConfigEntityType`) are counted via `$storage->loadMultiple()` + `count()`; content entity types via
  `$storage->getAggregateQuery()->count()->execute()`. A "Per bundle" dropbutton link is added only when
  `entity_type.bundle.info` reports more than one bundle.
- `perBundle()` iterates the bundles of `{entity_type}` and runs one `getQuery()` per bundle with a
  `condition($bundle_key, $bundle_id)->count()`; `$bundle_key` is the type's `bundle` entity key (falling
  back to the literal `'bundle'`).
- Both build a `#type => table` render array and sort rows with `TableSort` on the `Count` column (default
  sort is alphabetical by label). Details in [reports/entity-count.md](reports/entity-count.md).
