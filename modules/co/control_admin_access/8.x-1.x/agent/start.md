<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Control access to administration and privative pages (control_admin_access) — agent index

An HTTP kernel **middleware** plus one **config form** that blocks configured URL glob patterns with a bare
**HTTP 401** unless the client IP is in a configured allowlist. Package *Custom control access*. No dependencies
outside Drupal core. Core `^9 || ^10 || ^11`. License GPL-2.0-or-later. Version 8.x-1.x (installed 8.x-1.4).

- **The middleware, the config form, config keys, routes and permission, and how to operate it** →
  [config/settings.md](config/settings.md)

## What it actually is (from source)

- One service: `control_admin_access.middleware` → `Drupal\control_admin_access\CaaMiddleware`
  (`src/CaaMiddleware.php`), tagged `http_middleware` **priority 250** (ahead of page caching), constructed with
  `@config.factory` and `@path.matcher`. It implements `HttpKernelInterface` and decorates the kernel.
- One form: `Drupal\control_admin_access\Form\AdminControlAccess` (`src/Form/AdminControlAccess.php`), a
  `ConfigFormBase` editing config object **`control_admin_access.adminsettings`** (keys `whitelist`, `blocked_urls`).
- One route: `control_admin_access.form` → `/admin/config/system/control-admin-access`, permission
  **`administration access vpn`**, `_admin_route: TRUE`. Menu link `control_admin_access.admin` under
  *Configuration → System* (title "Control access VPN"). Configure route id: `control_admin_access.form`.
- One permission (`control_admin_access.permissions.yml`): `administration access vpn`
  ("Administer access VPN module").
- **No** entities, no plugins, no Drush, no hooks, no `.install`, no `config/install`, no `config/schema`.

## Mechanism (`CaaMiddleware::handle()`)

1. Reads `control_admin_access.adminsettings`. If `blocked_urls` is a non-empty array, calls `checkUrl()`:
   `pathMatcher->matchPath($request->getRequestUri(), implode("\n", $blocked_urls))` — a **glob** match against
   the raw request URI.
2. If the URL matches **and** `whitelist` is a non-empty array, calls `checkIp()`:
   `IpUtils::checkIp($request->getClientIp(), array_filter(array_map('trim', $whitelist)))`.
3. If the IP is **not** in the allowlist → returns a bare `Response` with status **401**; the request never
   reaches routing. Otherwise the request is passed to the decorated kernel unchanged.

## Operating notes (accurate behavior, not security advice)

- The gate is **purely additive** — it only *adds* a 401 in front of matching paths; it never grants access and
  is not a substitute for Drupal's permission system or authentication.
- A blocked pattern only enforces when a **non-empty whitelist** is also set; with `blocked_urls` set but
  `whitelist` empty, nothing is blocked.
- `getClientIp()` returns the real connecting IP unless **trusted reverse proxies are configured** in Drupal — a
  proxy/CDN deployment must configure trusted-proxy settings for the allowlist to see the true client IP.
- A misconfigured allowlist can lock all admins out of the blocked paths; recover with
  `drush cdel control_admin_access.adminsettings` (or edit config in the DB).
