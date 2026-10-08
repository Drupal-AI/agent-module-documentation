<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Install, routes, permission & the React embed

## Install & enable

```bash
composer require drupal/dash
drush en dash -y
```

Only dependency is core **`system`**. No sub-modules, no settings form, **no config objects or
schema**, no Drush commands. There is nothing to configure — grant the permission and open the
page.

## Permission

`dash.permissions.yml` defines a single permission:

- **`access modern dashboard`** — title *"Access modern dashboard"*, `restrict access: true`
  (flagged as security-sensitive in the People → Permissions UI). Grant it only to trusted admin
  roles; it controls both the dashboard page and every JSON data endpoint.

## Routes (`dash.routing.yml`)

| Route | Path | Controller | Requirement |
|---|---|---|---|
| `dash.dashboard` | `/admin/dashboard` | `DashboardController::page` | `_permission: access modern dashboard` |
| `dash.dashboard_data` | `/admin/dashboard/data/{widget}` | `DashboardDataController::widget` | same permission; `widget` matches `^[a-z0-9_]+$` |

Both routes set `options._admin_route: true`. `dash.links.menu.yml` adds a **Dashboard** menu link
(weight -20, parent `system.admin`, CSS class `dash-dashboard-menu-link`) pointing at
`dash.dashboard`.

## The page render (`DashboardController::page`)

Returns a render array with a single `#type => container` whose id is **`dash-dashboard-root`**,
empty markup, and:

- `#attached.library`: **`dash/dashboard`** — from `dash.libraries.yml`, loads the minified
  bundled React app `js/dist/dashboard.js` + `js/dist/dashboard.css`, depending on `core/drupal`,
  `core/once`, `core/drupalSettings`.
- `#attached.drupalSettings.dash`: `{ homeUrl: '/', dataBase: '/admin/dashboard/data' }`. The
  React SPA reads `dataBase` and fetches each widget as `${dataBase}/{widget}`.

The React source lives (uncompiled) under `js/app/` (Vite + Tailwind); only `js/dist/*` is shipped
and attached. Rebuilding requires Node — not needed to run the module.

## Page attachments hook (`DashHooks`)

`src/Hook/DashHooks.php` (`#[Hook('page_attachments')]`, with a `#[LegacyHook]` shim in
`dash.module`) attaches library **`dash/admin`** (`css/dash.admin.css`) to page attachments. It is
constructed with core's `AdminContext` (autowired) but the current implementation attaches the CSS
unconditionally.

## Operating notes

- No cron, no queue worker, no state writes of its own (it only *reads* `system.cron_last`).
- The dashboard is entirely read-only: it never creates, edits, or deletes content or config.
- Clearing caches (`drush cr`) invalidates the two internal status caches
  (`dash:status:summary`, `dash:status:system`) along with everything else.
