<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Usage Plus (entity_usage_plus) — agent index

Enhancements to the contrib **Entity Usage** module. Depends on `entity_usage:entity_usage`
(`drupal/entity_usage ~2.0`). Core `^10.2 || ^11`. License GPL-2.0-or-later. Version **1.1.x**
(1.1.1). No submodules, no own permissions, no Drush.

## What it actually provides (from source)

- A **Views filter** plugin `entity_usage_plus_unreferenced` ("Limit to unreferenced entities"),
  `src/Plugin/views/filter/EntityUnreferenced.php`. Added to every Entity-Usage-tracked entity
  type's Views data by `hook_views_data_alter()` in `src/Hook/EntityUsagePlusHooks.php`. Not
  exposable (`canExpose()` → FALSE). → [plugins/unreferenced-filter.md](plugins/unreferenced-filter.md)
- An **optional override of the Entity Usage "Usage" tab** so the table also lists a target
  entity's **children/grandchildren**, plus a media edit-form link. Controller
  `src/Controller/LocalTaskUsagePlusController.php` (extends `entity_usage`'s
  `LocalTaskUsageController`); wired in by `src/Routing/RouteSubscriber.php` only when the config
  flag is set. Theme hook `entity_usage_plus_usage_table` +
  `templates/entity-usage-plus-usage-table.html.twig`. → [config/settings.md](config/settings.md)
- A **settings form** at `/admin/config/entity-usage/settings/entity-usage-plus` (route
  `entity_usage_plus.settings`, permission `administer entity usage`), one checkbox
  `override_tab_display`. Config object `entity_usage_plus.settings` (schema in
  `config/schema/entity_usage_plus.schema.yml`, install default `override_tab_display: false`).
  → [config/settings.md](config/settings.md)

## Services / hooks

- `entity_usage_plus.route_subscriber` (`RouteSubscriber`) — event_subscriber, priority 98 on
  `RoutingEvents::ALTER`.
- `Drupal\entity_usage_plus\Hook\EntityUsagePlusHooks` — autowired OOP hook class implementing
  `views_data_alter` and `theme` (the `.module` file delegates to it via `#[LegacyHook]`).

## Access / safety

Uses Entity Usage's permissions only. The usage tab honors entity access — labels need
`view label`, links need `view` (media: `edit`); otherwise "- Restricted access -" is shown. The
unreferenced filter cannot be exposed to end users.
