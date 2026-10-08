<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Custom Admin URL (custom_admin_url) — agent index

Confines the administration surface to a **designated back-office host**: adds a custom access check
to every `admin/*` and `user/*` route that returns **403** unless the request host matches a
configured back-office URL. Package `Custom admin URL`. **No dependencies** beyond core. Core
`^10 || ^11`. License GPL-2.0-or-later. Version `1.0.x` (dev branch).

- **Install/enable, the settings form, config object, and exactly how the access gate decides** →
  [config/settings.md](config/settings.md)

## What it actually is

- A **route subscriber** + a **custom access checker** + one **settings form**. No entities, no
  plugins, no permissions of its own, no Drush, no hooks, no JS/CSS.
- `Routing\RouteSubscriber::alterRoutes()` iterates the whole `RouteCollection`; for any route whose
  path's second segment (`explode('/', rtrim(path,'/'))[1]`) is in `ADMIN_PATHS = ['admin','user']`
  it calls `$route->addRequirements(['_custom_access' => '…AccessController::access'])`. This is an
  **additive** requirement (Drupal ANDs access checks), so it can only tighten, never widen, access.
- `Controller\AccessController::access(AccountInterface $account)` (constructed with the current
  `Request` from `request_stack`): reads `bo_url` from config `custom_admin_url.settings`.
  - If `bo_url` is set **and** `Request::getHost() !== $bo_url` → `AccessResult::forbidden()` (403).
  - Else if route is `user.login` → `AccessResult::allowed()`.
  - Else → `AccessResult::allowedIfHasPermissions($account, ['access administration pages'])`.

## Config & routes

- Config object **`custom_admin_url.settings`**, key **`bo_url`** (string host, e.g.
  `back.example.com`; install default `''`). Note: `config/schema/…schema.yml` only defines an
  `example` string mapping, **not** `bo_url` — the stored key is effectively schema-less.
- Settings form **`Form\CustomAdminUrlForm`** (getFormId `custom_admin_url_custom_admin_url`), route
  **`custom_admin_url.settings`** at `/admin/config/system/custom-admin-url`, permission
  **`administer site configuration`**; menu link under *Configuration → System*
  (`custom_admin_url.links.menu.yml`). `bo_url` is validated with `UrlHelper::isValid($url, FALSE)`.
- Service: `custom_admin_url.route_subscriber` (tagged `event_subscriber`).

## Operating notes (from source, not a security disclosure)

- The gate keys on **`Request::getHost()`** (a host string), so its integrity depends on the site's
  `trusted_host_patterns` being set. It is **defense-in-depth**, complementing — not replacing —
  role/permission checks.
- Because the checker also requires `access administration pages` on every matched `user/*` route
  (login excepted), enabling the module changes access on core account routes (register, password,
  profile, logout) for non-admin users — verify account flows after enabling. See
  [config/settings.md](config/settings.md).
