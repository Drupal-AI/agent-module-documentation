<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cookie SameSite support (cookie_samesite_support) — agent index

Sets **`SameSite=None`** on Drupal's session cookie and emits a **legacy duplicate** without the
attribute for browsers that reject the value, so an authenticated Drupal site keeps working when it
is used **cross-site** — embedded in an iframe on another domain, or returning from an external
redirect (payment-gateway / 3-D-Secure). It ships **no UI, no routes and no config**; it works purely
by **decorating two core services**: `session_manager` (class `CookieSameSiteSupportSessionManager`)
and `session_configuration` (class `CookieSameSiteSupportSessionConfiguration`). The source cites
web.dev's SameSite cookie recipes. Version **1.1.1**, core `^9 || ^10 || ^11`.

Mechanism: on session save, `CookieSameSiteSupportSessionManager::save()` re-emits the `Set-Cookie`
header with `; SameSite=None` appended and also writes a second cookie named `<name>-legacy` with the
attribute stripped (constant `LEGACY_SUFFIX = '-legacy'`) for clients that drop `None` outright. On
the next request, `CookieSameSiteSupportSessionConfiguration::getName()` runs `setCookieFromLegacy()`,
which — when the canonical session cookie is missing but its `-legacy` twin is present — copies the
legacy value back into the canonical cookie (`Secure`, `SameSite=None`) so the session survives across
browsers old and new. This is the standard two-cookie workaround for incompatible clients.

- Depends on: **nothing** (info.yml declares no `dependencies`). Core: `^9 || ^10 || ^11`.
  Package: `Cookies Management`. PHP `>=7.4.0` (composer.json).
- **No** settings page / `configure` route, **no** permissions, **no** drush commands, **no** plugin
  types, **no** hooks, **no** `.module`/`.install`, **no** config schema. Enabling it is the entire
  activation — the behaviour is site-wide and all-or-nothing (no per-cookie/per-route toggle).
- **Requires HTTPS site-wide.** `SameSite=None` is only honoured by browsers together with `Secure`,
  and the legacy-restore path hard-codes `'secure' => TRUE`. Over plain HTTP the cookie is dropped and
  the module cannot help.

## What you'd do → where

- **Enable it, make it take effect, verify the two cookies appear, and understand the HTTPS/`Secure`
  prerequisite plus the site-wide (all-or-nothing) scope** → [configure/settings.md](configure/settings.md)

## Key facts (real machine names)

- Services (both `public: false` decorators, in `cookie_samesite_support.services.yml`):
  - `cookie_samesite_support.session_manager` → `decorates: session_manager`, class
    `Drupal\cookie_samesite_support\Session\CookieSameSiteSupportSessionManager`, tag
    `backend_overridable`, call `setWriteSafeHandler(@session_handler.write_safe)`.
  - `cookie_samesite_support.session_configuration` → `decorates: session_configuration`, class
    `Drupal\cookie_samesite_support\Session\CookieSameSiteSupportSessionConfiguration`, args
    `@datetime.time`, `%session.storage.options%`.
- Overridden methods: `CookieSameSiteSupportSessionManager::save()`
  (`src/Session/CookieSameSiteSupportSessionManager.php:29`);
  `CookieSameSiteSupportSessionConfiguration::getName()` + protected `setCookieFromLegacy()`
  (`src/Session/CookieSameSiteSupportSessionConfiguration.php:37`, `:53`).
- Constant: `CookieSameSiteSupportSessionManager::LEGACY_SUFFIX = '-legacy'` — suffix appended to the
  session-cookie name for the duplicate cookie.
- Cookies emitted: the site session cookie (e.g. `SESS<hash>`) as `…; secure; SameSite=None`, plus
  `SESS<hash>-legacy` as `…; secure` (no `SameSite`).
- Reads Drupal's own session-cookie settings — `%session.storage.options%` (injected) and
  `session_get_cookie_params()`; it adds no config keys of its own.
