<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Count — the report routes & controller

Everything the module does lives in `src/Controller/EntityCountController.php` plus three tiny YAML files.
No config, no schema, no install hook.

## Install / enable

`drush en entity_count`. No configuration screen (`configure` is null). Grant the **`access entity count`**
permission to the roles that should see the report, then visit Administration > Reports → "Entity count".

## Routes & access (`entity_count.routing.yml`)

| Route | Path | Controller method | Requirement |
|---|---|---|---|
| `entity_count` | `/admin/reports/entity-count` | `EntityCountController::entityCount` | `_permission: access entity count` |
| `entity_count.per_bundle` | `/admin/reports/entity-count/{entity_type}` | `EntityCountController::perBundle` | `_permission: access entity count` |

`entity_count.links.menu.yml` adds the `entity_count` link under `system.admin_reports`. Both routes are
read-only GET requests returning a render array; there are no forms and no state changes.

## Permission (`entity_count.permissions.yml`)

- `access entity count` (title "Access entity count"). This is the only permission and the only gate on both
  reports.

## `EntityCountController`

Extends `ControllerBase`. `create()` injects three core services: `entity_type.manager`
(`EntityTypeManagerInterface`), `entity_type.bundle.info` (`EntityTypeBundleInfoInterface`), and `renderer`
(`Renderer`).

### `entityCount(Request $request): array`

- Header: `Entity type`, `Count` (sortable, `field => count`), `Actions`.
- Loops `entityTypeManager->getDefinitions()`. For each definition:
  - If `get_class($definition) == 'Drupal\Core\Config\Entity\ConfigEntityType'` → `count($storage->loadMultiple())`.
  - Otherwise (content entity types) → `$storage->getAggregateQuery()->count()->execute()`.
  - If `entityTypeBundleInfo->getBundleInfo(id)` has more than one bundle, renders a `#type => dropbutton`
    with a single "Per bundle" link to `entity_count.per_bundle` (rendered to markup via the injected
    `renderer`); otherwise the Actions cell is empty.
- Sorting: `TableSort::getOrder()` / `getSort()` — when ordered by the `Count` column it `usort()`s numerically
  (asc/desc via the `<=>` spaceship on the count); otherwise it `strcmp()`s by the entity-type label.
- Returns a `#type => table` render array with the assembled `#rows`.

### `perBundle(Request $request, string $entity_type): array`

- Header: `Bundle`, `Count` (sortable).
- Loops `entityTypeBundleInfo->getBundleInfo($entity_type)`. For each bundle it derives the bundle key from
  `entityTypeManager->getDefinition($entity_type)->getKeys()['bundle']` (falling back to the literal
  `'bundle'` when null), then runs `getStorage($entity_type)->getQuery()->condition($bundle_key, $bundle_id)->count()->execute()`.
- Same `TableSort` numeric/`strcmp` sorting as above (label column here is the bundle label).
- Returns a `#type => table` render array. If `$entity_type` has no bundle info the loop is empty and the
  table renders with no rows.

## Operating notes

- Output is aggregate integer counts only — no entity titles, IDs, or rows are listed; the per-type report
  links to the per-bundle report, and the per-bundle report is a flat table of bundle → count.
- Counts reflect the current database state at request time; there is no caching layer added by the module,
  so each view re-runs the aggregate/count queries.
- The `{entity_type}` parameter is used only to look up bundle info and load storage through the entity type
  manager; an unknown type yields an empty report rather than an error.
- Config entity types are counted by loading them all into memory (`loadMultiple`), which is fine for normal
  config volumes; content types use lightweight aggregate `COUNT` queries.
