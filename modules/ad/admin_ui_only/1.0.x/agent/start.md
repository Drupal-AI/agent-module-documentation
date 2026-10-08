<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Admin UI Only (admin_ui_only) — agent index

Makes a Drupal site serve **only its admin UI over HTML**: a response event subscriber returns
**403/404** for `200` `text/html` responses on non-admin routes, while leaving non-HTML formats
(JSON:API, GraphQL, REST) untouched. For decoupled/API-only backends. Package **Web services**.
No dependencies beyond core. Core `^9 || ^10 || ^11`. PHP **8.0**. License GPL-2.0-or-later.
Version **1.0.3** (dir `1.0.x`).

## What it actually is

- **One service**: `Drupal\admin_ui_only\EventSubscriber` (tagged `event_subscriber`, args
  `@config.factory`, `@router.builder`). No entities, no plugins, no permissions of its own, no
  Drush.
- **One config object**: `admin_ui_only.settings` (`routes`: sequence of route names; `error_code`:
  403 or 404). Schema in `config/schema/admin_ui_only.schema.yml`; defaults `routes: []`,
  `error_code: 403` in `config/install/`.
- **One route/form**: `admin_ui_only.settings_form` at `/admin/config/admin_ui_only`
  (`_permission: administer site configuration`) → `Drupal\admin_ui_only\Form\SettingsForm`.
  Menu link under *Configuration → Web services* (`system.admin_config_services`).
- **Hooks** (`admin_ui_only.module`): `hook_help`; `hook_form_node_form_alter` adds a submit handler
  that redirects to `system.admin_content` after saving a node. `admin_ui_only.install` sets
  `node.settings:use_admin_theme = TRUE` on install / when `node` is later enabled.

## The gate (`EventSubscriber`)

- `onKernelRespond` (`KernelEvents::RESPONSE`) — the enforcement point. On the **main** request, if
  `status === 200` AND `Content-Type` contains `text/html` AND `deny($request)` is TRUE, it throws
  `NotFoundHttpException` when `error_code === 404`, else `AccessDeniedHttpException` (403).
- `deny()` — allow (return FALSE) when the request format is **not** `html`, OR the matched route
  has the `_admin_route` option; the **front page `/` is always allowed**; everything else is denied.
- `onAlterRoutes` (`RoutingEvents::ALTER`, prio 30) — sets `_admin_route = TRUE` on a hardcoded
  `ADMIN_ROUTES` list (user login/logout/register/reset/edit/cancel/contact, `user.page`,
  `entity.user.canonical`, `media.oembed_iframe`, `system.batch_page.html`) plus every route name in
  `admin_ui_only.settings:routes`.
- `onConfigSave` (`ConfigEvents::SAVE`) — rebuilds the router if `routes` changed; invalidates the
  `4xx-response` cache tag if `error_code` changed.

## Docs

- **Configuration, config object, schema, the settings form** →
  [config/settings.md](config/settings.md)
- **The request/response gate mechanism, exactly what is allowed vs blocked** →
  [architecture/request-gate.md](architecture/request-gate.md)
