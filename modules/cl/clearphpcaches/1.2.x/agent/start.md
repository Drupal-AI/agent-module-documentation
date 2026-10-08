<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Clear PHP Caches (clearphpcaches) — agent index

Adds one admin action that clears PHP's own runtime caches — **APCu** (`apcu_clear_cache()`)
and **OPcache** (`opcache_reset()`) — from the browser, so ops/DevOps can flush stale
compiled PHP after a deploy without shelling into the server or restarting PHP-FPM. There is
**no settings form and no stored config**; enabling the module and granting one permission is
the entire setup. Source read at version **1.2.0**; documented under version dir `1.1.x`.
Core `^10 || ^11`, PHP 8.1+. License GPL-2.0-or-later.

## Dependencies

- Drupal module **`admin_toolbar:admin_toolbar`** (hard dependency in `.info.yml`). It only
  supplies the toolbar parent for the menu link; the module still works without the toolbar —
  the route is reachable directly.
- No PHP libraries beyond core (`composer.json` requires only `drupal/core`).

## What it provides (from source)

- **Route** `clearphpcaches.flush` (`.routing.yml`) → `GET /admin/flush/phpcaches`,
  `_controller: ClearPhpCachesController::flush`, gated by `_permission: 'clear php caches'`.
- **Controller** `src/Controller/ClearPhpCachesController.php`:
  - `flush()` — adds the message `APC and OPCache cleared.`, then calls `apcu_clear_cache()`
    and `opcache_reset()` (no arguments; nothing user-supplied is passed), then returns a
    `RedirectResponse` to `reloadPage()`.
  - `reloadPage()` — returns `HTTP_REFERER` if present, else `base_path()` (see the redirect
    behaviour note below).
  - Injects only `request_stack`.
- **Permission** `clear php caches` (`.permissions.yml`) — `restrict access: true`, so it is
  **not** granted to any role by default and is flagged as security-sensitive in the UI.
- **Menu link** `clearphpcaches.flush` (`.links.menu.yml`) — "Clear APC and OPCache" under
  `admin_toolbar_tools.flush`, weight -100. This is the only reason `admin_toolbar` is required.
- **`.module`** file contains a documentation header only — no hooks, no code.
- No config/, no schema, no libraries, no install/update hooks, no services file, no submodules.

## Behaviour notes

- The flush route (`GET /admin/flush/phpcaches`) clears APCu and OPcache when it is loaded, then
  redirects back to the page you came from. It is reached from the "Clear APC and OPCache" toolbar
  link and is gated by the restricted `clear php caches` permission (see above) — grant it only to
  trusted operator roles.
- `reloadPage()` hands the `HTTP_REFERER` to a redirect response; core's
  `RedirectResponseSubscriber` converts it to a `LocalRedirectResponse`, so an off-site referer
  yields a **400 "Redirects to external URLs are not allowed"** response (a UX edge case). The
  caches are cleared regardless of where the redirect resolves.

## Tests (in source)

- `tests/src/Unit/.../ClearPhpCachesControllerTest.php` — `reloadPage()` returns referer, else
  `base_path()`.
- `tests/src/Functional/ClearPhpCachesFunctionalTest.php` — 403 without permission, 200 with it,
  redirect back to referer, and the success message.

## Usage / manual docs

- Prose overview and one-liners → [../usage.md](../usage.md)
- Human click-through guide → [../human-docs/index.md](../human-docs/index.md)
