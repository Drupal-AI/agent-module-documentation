<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Dashboards Extra (dashboards_extra) — agent index

Seven drop-in **statistics widgets** for the contrib **Dashboards** module. Each is a `@Dashboard`
plugin (category *"Dashboards: Extras"*) that runs an aggregate `COUNT` entity query and renders a
chart via Dashboards' `ChartTrait`. Package: default (no `package:` in info). Depends only on
**`dashboards:dashboards`**. Core `^10 || ^11`. License GPL-2.0-or-later. Version 1.0.1.

- **The seven widgets, their settings, queries and how to place them** →
  [plugins/statistics-widgets.md](plugins/statistics-widgets.md)

## What it actually is

- No routes, no `*.services.yml`, no `*.permissions.yml`, no `*.install`, no `config/` (no schema
  or install config), no hooks. `dashboards_extra.module` is an empty `<?php`. The whole module is
  seven plugin classes under `src/Plugin/Dashboard/`.
- It contributes **plugin instances**, not a new plugin type — the `@Dashboard` type, the base
  class `DashboardBase`, the cache service `dashboards.cache` and `ChartTrait` all come from the
  `dashboards` module.
- Access is governed entirely by the **Dashboards module's** dashboard permissions/UI; this module
  adds none of its own.

## The seven plugins (`src/Plugin/Dashboard/`)

| id | class | entity storage | groups by | scope |
|----|-------|----------------|-----------|-------|
| `content_statistics` | `ContentStatistics` | `node` | `type` | published flag, current langcode |
| `my_content_statistics` | `MyContentStatistics` | `node` | `type` | + `uid` = current user |
| `block_statistics` | `BlockStatistics` | `block_content` | `type`,`langcode` | published flag |
| `my_block_statistics` | `MyBlockStatistics` | `block_content` | `type`,`langcode` | + `content_translation_uid` = current user |
| `media_statistics` | `MediaStatistics` | `media` | `bundle` | published flag |
| `vocabulary_statistics` | `VocabularyStatistics` | `taxonomy_term` | `vid` | published flag, current langcode |
| `users_statistics` | `UsersStatistics` | `user` | `roles` | (no bundle filter; no publish) |

Each plugin's `buildSettingsForm()` offers a `chart_type` select and (except Users) a required
multi-select of bundles plus a `publish` checkbox; `buildRenderArray()` executes the aggregate
query and feeds label/count rows to `renderChart()`. Details in
[plugins/statistics-widgets.md](plugins/statistics-widgets.md).

## Known caveat (from source)

- `UsersStatistics.php` and `MediaStatistics.php` declare namespace `Drupal\dashboard_extra`
  (singular) instead of `Drupal\dashboards_extra`. Under PSR-4 those classes will not autoload from
  the `dashboards_extra` module, so the `users_statistics` and `media_statistics` widgets are
  effectively **not discoverable/usable** as shipped. See the solution doc.
