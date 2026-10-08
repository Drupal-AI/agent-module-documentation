<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Acquia CMS Headless UI (acquia_cms_headless_ui) — agent index

**Pure headless mode** submodule of Acquia CMS Headless. Disables Drupal's front end and
restructures the admin experience around the JSON:API. Package `Acquia CMS`. Core `^10 || ^11`.
GPL-2.0-or-later. Version 1.4.1. Depends on `acquia_cms_headless` + core `path_alias`. No own
permissions, config schema, or Drush. Normally toggled by the parent's "Enable Headless mode"
checkbox.

## Solution doc

- **Install handler, routes, config subscriber, hooks (menu/toolbar/preview rewrites)** →
  [config/pure-headless.md](config/pure-headless.md)

## What it provides (from source)

- **Service** `acquia_cms_headless.pure_headless_mode` (`Service\PureHeadlessModeInstallHandler`) —
  creates/deletes the headless path aliases and applies/reverts the headless config changes
  (front page `/frontpage`, 403 → `/user/login`, Gin theme, content-view link toggles,
  `headless_mode` flag). Run from `hook_install` / `hook_uninstall`.
- **Config subscriber** `Drupal\acquia_cms_headless_ui\EventSubscriber\ConfigSubscriber` — on
  `system.site` save re-pins `page.front => /frontpage`; clears local-task cache on
  `media.settings` `standalone_url` change.
- **Route subscriber** `Routing\SitePreviewRouteSubscriber` — repoints `entity.node.latest_version`
  to `/node/{node}/site-preview`.
- **Routes** (`acquia_cms_headless_ui.routing.yml`): `/frontpage` (login,
  `FrontController::frontpage`, `_access: TRUE`); `/admin/access` + `/admin/access/users`;
  `/admin/content-models`; `/admin/cms`; `entity.node.headless_preview`
  (`/node/{node}/site-preview`, `SitePreviewController`, `_entity_access: node.view` +
  content_moderation dep; parent adds `_preview_link_access_check`).
- **Controllers**: `FrontController` (login/redirect front page), `SitePreviewController`
  (Next.js preview of latest revision via `next` site-previewer plugin).
- **Menu local task** `Menu\ViewJsonTask` — rewrites entity "View" tabs to the JSON:API individual
  route.
- **Redirect helper** `Redirect` — sends entity add/edit forms back to their list views.
- **Hooks** (`acquia_cms_headless_ui.module`): `hook_help`, `hook_user_login` (default login
  destination), `hook_local_tasks_alter` / `hook_menu_links_discovered_alter` /
  `hook_toolbar_alter` (rebuild the admin nav), `hook_entity_operation_alter`,
  `hook_ENTITY_TYPE_create` (node_type) and several `hook_form_*_alter` that strip front-end node
  options.
