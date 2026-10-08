<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Dashboards Extra — statistics widgets (`@Dashboard` plugins)

All seven classes live in `src/Plugin/Dashboard/`, extend `Drupal\dashboards\Plugin\DashboardBase`,
use `Drupal\dashboards\Plugin\Dashboard\ChartTrait`, and are annotated:

```
@Dashboard(
  id = "<id>",
  label = @Translation("<Label>"),
  category = @Translation("Dashboards: Extras"),
)
```

There is no config schema in this module; each widget's settings are stored by the **Dashboards**
module as part of the dashboard/section it is placed in.

## Install / enable

1. `ddev composer require drupal/dashboards_extra` (pulls `drupal/dashboards`).
2. `ddev drush en dashboards_extra -y` (enables `dashboards` too).
3. Edit a dashboard in the Dashboards UI; the widgets appear under the **"Dashboards: Extras"**
   category. Place one, then configure it (below).

## Common constructor / DI (all seven)

`__construct($configuration, $plugin_id, $plugin_definition, CacheBackendInterface $cache,
QueryAggregateInterface $query_factory, EntityTypeBundleInfoInterface $entity_type_info)`.
`create()` injects:
- `dashboards.cache` → `$cache` (passed to `DashboardBase`),
- `entity_type.manager`→`getStorage('<entity>')->getAggregateQuery('AND')` → `$this->entityQuery`,
- `entity_type.bundle.info` → `$this->entityTypeInfo`.

Because the aggregate query is built once at construction, each widget targets a single hard-coded
entity type (see table in [../start.md](../start.md)).

## Settings form (`buildSettingsForm()`)

- `chart_type` — `select` of `ChartTrait::getAllowedStyles()`, default `'pie'`.
- Bundle multi-select (`#multiple`, `#required`) — options from
  `entityTypeInfo->getAllBundleInfo()[<entity>]`:
  - `node_type` (Content / My Content), `block_type` (Block / My Block), `media_type` (Media),
    `taxonomy_term_type` (Vocabulary).
  - `UsersStatistics` has **no** bundle select (it always groups by role).
- `publish` — `checkbox`, default TRUE (Content, My Content, Block, My Block, Media, Vocabulary).
  Users has no publish option.

## Render (`buildRenderArray($configuration)`)

Sets chart type from config, then runs an aggregate query and pushes `[label, count]` rows via
`setLabels([...])` + `setRows($rows)` + `return $this->renderChart($configuration)`.

- **ContentStatistics** (`content_statistics`): `node` storage. Query conditions `type IN
  node_type` (the `type` condition is duplicated in source — harmless), `status = publish`,
  `langcode = current`, `groupBy('type')`, `aggregate('nid','COUNT')`, `accessCheck(FALSE)`.
  Rows: content-type label → `nid_count`.
- **MyContentStatistics** (`my_content_statistics`): same as above plus `uid = current user id`;
  `groupBy('type')`, `aggregate('nid','COUNT')`.
- **BlockStatistics** (`block_statistics`): `block_content` storage. `type IN block_type`,
  `status = publish`, `groupBy('type')`,`groupBy('langcode')`, `aggregate('id','COUNT')`. Rows are
  filtered in PHP to the current interface language.
- **MyBlockStatistics** (`my_block_statistics`): as Block plus `content_translation_uid = current
  user id`.
- **MediaStatistics** (`media_statistics`): `media` storage. `bundle IN media_type`,
  `status = publish`, `groupBy('bundle')`, `aggregate('mid','COUNT')`.
- **VocabularyStatistics** (`vocabulary_statistics`): `taxonomy_term` storage. `vid IN
  taxonomy_term_type`, `status = publish`, `langcode = current`, `groupBy('vid')`,
  `aggregate('tid','COUNT')`.
- **UsersStatistics** (`users_statistics`): `user` storage. `groupBy('roles')`,
  `aggregate('uid','COUNT')`, `accessCheck(FALSE)`. Loads `user_role` entities for labels.

All output is **aggregate counts** grouped by bundle/role — never entity titles, ids, or URLs — and
is only rendered inside a Dashboards dashboard (gated by the Dashboards module's own access). The
required bundle multi-select means an admin explicitly picks which bundles a widget counts.

## Behavioral caveats (grounded in source)

- **Namespace bug — two widgets are unusable as shipped.** `UsersStatistics.php` and
  `MediaStatistics.php` declare `namespace Drupal\dashboard_extra` (singular). PSR-4 for this module
  is `Drupal\dashboards_extra` (plural), so those classes will not autoload → the plugin manager
  cannot instantiate `users_statistics` / `media_statistics`. The other five use the correct plural
  namespace.
- **`empty()` checks use the wrong variable.** In `ContentStatistics`, `MediaStatistics` and
  `UsersStatistics` the "no data" branch tests `empty($result)` (the leftover loop variable) instead
  of `$results`; the intended `setEmpty(TRUE)` path may not trigger reliably.
- **Users role rows rarely populate.** `UsersStatistics::buildRenderArray()` reads
  `$result["roles_target_id"]` but the aggregate key produced is `roles` (via `groupBy('roles')`),
  and it guards on `isset($r["roles_target_id"])` — `$r` is never defined — so no rows are appended.
  Combined with the namespace bug, the Users widget is doubly non-functional as shipped.
- Bundle selects are `#required`; a widget saved before a bundle exists (e.g. no media types) will
  offer an empty options list.
