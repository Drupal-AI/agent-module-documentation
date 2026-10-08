<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CacheFlusher (cacheflusher) — agent index

One-click "flush all caches" link in the admin toolbar/menu. Version 2.2.0, package `Cache`,
core `^10 || ^11`. No dependencies, no config, no services/plugins/entities, no Drush commands.

## What it provides
- **Route** `cacheflusher` → `GET /admin/cacheFlusher`, controller
  `Drupal\cacheflusher\Controller\CacheFlusherController::cacheFlusherCacheClear`
  (src/Controller/CacheFlusherController.php). Calls `drupal_flush_all_caches()`, sets an
  "All Caches cleared." message, then redirects to the HTTP referer.
- **Permission** `access cache flusher` (cacheflusher.permissions.yml) — gates the route.
- **Menu link** `cacheflusher` (cacheflusher.links.menu.yml), parent `system.admin`, weight 1.
- **Library** `cacheflusher/cacheflusher-styling` (cacheflusher.libraries.yml) — a reload-icon
  CSS file (`presentation/cacheflusher.icons.theme.css`), attached on every page by
  `cacheflusher_page_attachments()` in cacheflusher.module.
- Icon assets: `presentation/icons/000000/` and `presentation/icons/787878/` (reload.svg/png).

## Not present
No `config/install`, no `config/schema`, no `*.services.yml`, no plugins, no entities, no
`.install`, no settings form (`configure` is null), no Drush commands.

## Solution docs
- [Route, permission & controller](routes/cache-flush.md) — install/enable, how the flush works,
  the menu link, the styling library, and how to operate it.
