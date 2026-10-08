<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Modern Drupal Dashboard (dash) — agent index

A **React-powered admin dashboard** at **`/admin/dashboard`** that reports content, user, entity,
module, system, and health metrics. Package *Administration*. Depends only on core **`system`**.
Core `^10.3 || ^11`. License GPL-2.0-or-later. Version 1.0.6. **No settings form, no config
schema, no Drush, no plugin types.**

- **Routes, the permission, the React embed, and how to operate it** →
  [config/overview.md](config/overview.md)
- **The 11 JSON widget endpoints, their payloads and the services behind them** →
  [api/widgets.md](api/widgets.md)

## What it actually is

- **Two routes** (`dash.routing.yml`), both `_admin_route` and both gated by the single
  permission **`access modern dashboard`** (`restrict access: true`):
  - `dash.dashboard` → `/admin/dashboard` → `DashboardController::page()` renders an empty
    `#dash-dashboard-root` container, attaches library `dash/dashboard` (bundled
    `js/dist/dashboard.js` React app) and `drupalSettings.dash` = `{ homeUrl: '/', dataBase:
    '/admin/dashboard/data' }`.
  - `dash.dashboard_data` → `/admin/dashboard/data/{widget}` (`widget` regex `^[a-z0-9_]+$`) →
    `DashboardDataController::widget()` `match()`-dispatches to one of 11 widget methods; unknown
    keys throw `NotFoundHttpException` (404).
- **Services** (`dash.services.yml`): a `DashboardData` facade (service id `dash.dashboard_data`)
  aggregates six data services — `ContentDataService`, `UsersDataService`, `EntitiesDataService`,
  `StatusDataService`, `ModulesDataService`, `HealthDataService` — plus `ModuleCatalog` (grouped
  machine-name lists for the audits). `DashHooks` implements `hook_page_attachments` to attach the
  `dash/admin` CSS library site-wide (admin pages).
- **Provides:** one permission, one menu link (`dash.links.menu.yml`, "Dashboard", weight -20 under
  `system.admin`), two libraries (`dash.libraries.yml`: `admin` CSS, `dashboard` JS+CSS). No
  entities, no config, no hooks beyond page attachments.

## Data model (read-only)

- Every widget endpoint returns a `CacheableJsonResponse` (per-widget cache tags such as
  `node_list`, `user_list`, `config:core.extension`; `user.permissions` context; max-age 30–300s).
- All entity-count queries use `->accessCheck(TRUE)`. Direct DB `select()` queries hit
  `node_field_data`, `users_field_data`, `user__roles`, `watchdog`, `queue`, media tables — and
  return **only aggregate counts**, never row content.
- `StatusDataService` caches its requirements summary (`dash:status:summary`, 300s) and system
  snapshot (`dash:status:system`, 3600s) in `cache.default`; cron-last-run is always read fresh
  from state.

## Operate

- Install: `composer require drupal/dash` then `drush en dash -y`. Grant **Access modern
  dashboard** to trusted admin roles, visit `/admin/dashboard`.
- Some health/audit checks light up only when optional modules exist (media, metatag, update,
  dblog, big_pipe, seckit, honeypot, pathauto, simple_sitemap/xmlsitemap, redis/memcache, etc.) —
  see [api/widgets.md](api/widgets.md).
